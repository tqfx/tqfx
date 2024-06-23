source $VIMRUNTIME/defaults.vim

set nocompatible "cp 本选项的效果是使得 Vim 或者更兼容 Vi
set autoindent "ai 根据上一行决定新行的缩进
set autoread "ar 有 Vim 之外的改动时自动重读文件
set nobackup "bk 覆盖文件时保留备份文件
set confirm "cf 询问如何处理未保存/只读的文件
set cursorline "cul 高亮光标所在屏幕行
set encoding=UTF-8 "enc 内部使用的编码方式
set expandtab "et 键入 <Tab> 时使用空格
set foldlevel=99 "fdl 当折叠级别高于此值时关闭折叠
set guicursor=a:ver10-Cursor "gcr GUI: 光标形状和闪烁的设置
set hidden "hid 允许隐藏被修改过的缓冲区
set ignorecase "ic 搜索模式时忽略大小写
set list "显示 <Tab> 和 <EOL>
set listchars=tab:-->,space:· "lcs list 模式下显示用的字符
set mouse=a "允许使用鼠标点击
set number "nu 行前显示行号
set shiftwidth=4 "sw (自动) 缩进使用的步进单位，以空白数目计
set showmatch "sm 插入括号时短暂跳转到匹配的括号
set noshowmode "smd 在状态行上显示当前模式的消息
set showtabline=2 "stal 是否显示标签页行
set sidescroll=8 "ss 横向滚动的最少列数
set sidescrolloff=8 "siso 在光标左右最少出现的列数
set signcolumn=yes "scl 何时显示标号列
set smartcase "scs 模式中有大写字母时不忽略大小写
set smartindent "si C 程序智能自动缩进
set softtabstop=4 "sts 编辑时 <Tab> 使用的空格数
set splitbelow "sb 新窗口在当前窗口之下
set splitright "spr 新窗口在当前窗口之右
set noswapfile "swf 缓冲区是否使用交换文件
set tabstop=4 "ts <Tab> 在文件里使用的空格数
set termguicolors "tgc 终端使用 GUI 颜色
set updatetime=200 "ut 刷新交换文件所需的毫秒数
set whichwrap=b,s,<,>,[,] "ww 允许指定键跨越行边界
set wildmenu "wmnu 命令行自动补全所使用的菜单
set nowritebackup "wb 覆盖文件时建立备份

call plug#begin()

Plug 'preservim/nerdtree'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" +==================================== nerdtree =====================================+ "

map <C-n> :NERDTreeToggle<CR>

" +==================================== nerdtree =====================================+ "
" +===================================== rainbow =====================================+ "

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" +===================================== rainbow =====================================+ "
" +================================== vim-code-dark ==================================+ "

" Make the background transparent
let g:codedark_transparent=1

colorscheme codedark

" +================================== vim-code-dark ==================================+ "
" +===================================== airline =====================================+ "

" If you have vim-airline, you can also enable the provided theme
let g:airline_theme = 'codedark'

" +===================================== airline =====================================+ "
" +==================================== coc.nvim =====================================+ "

let g:coc_global_extensions = ['coc-git', 'coc-json', 'coc-cmake', 'coc-clangd', 'coc-pyright', 'coc-snippets', 'coc-highlight']

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" +==================================== coc.nvim =====================================+ "
