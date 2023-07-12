class ArticlesController < ApplicationController
  # http_basic_authenticate_with name: "test", password: "test", except: [:index, :show]
  def index
    #using the below line alone renders default articles/index.html.erb view
    @articles = Article.all
    # using the render loine below returns json to broswer and be used to implement react FE
    #  render json: @articles
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create  
    @article = Article.new(
      title: params[:title],
      body: params[:body],
      status: params[:status]
    )

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
