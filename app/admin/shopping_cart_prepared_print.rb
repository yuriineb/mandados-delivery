ActiveAdmin.register ShoppingCart, as: "print_prepareds" do
	menu false

  index :title => 'Despachos Listos para Entrega' do
    render partial: 'print_prepared'
  end

  action_item :atras, only: :index do
    link_to "Volver", session[:admin_url_prepared]
  end
    
    actions :all, except: [:new, :destroy]
    filter :get_zone_in, as: :select, collection: Zone.all.map {|r| [r.get_zone_full, r.id]}, label: 'Zona'
    # before_filter :skip_sidebar!, :only => :index


  controller do
    def scoped_collection
      @zonas = Zone.all
      @buyer_delivered = Buyer.select(:id).group(:id).joins(:shopping_carts).where("status_cart > :statuscart", {statuscart: StatusCart::ENVIADO}).map{|i| i.id}
      super.where(status_cart: StatusCart::ENVIADO)
    end

  end

end