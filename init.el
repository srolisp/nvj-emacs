;; Decrease the GC frequency by setting the threshold high for
;; configuration loading. The threshold will be set lower at the end
;; of the configuration to make each GC call faster for normal emacs
;; use.
(setq gc-cons-threshold (* 60 1024 1024))

;; Personal information

(setq user-full-name "xrlisp"
      user-mail-address "srolisp@gmail.com"
      calendar-latitude 35.866669
      calendar-longitude 128.600006
      calendar-location-name "Daegu, Korea")

(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-compile
  :config (auto-compile-on-load-mode))

(setq load-prefer-newer t)

(use-package better-defaults)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Make the y or n suffice for a yes or no question
(fset 'yes-or-no-p 'y-or-n-p)

(save-place-mode t)

(setq tab-width 4)

(setq scroll-error-top-bottom t)

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

(delete-selection-mode t)

(setq kill-whole-line t)

(setq track-eol t)

(global-auto-revert-mode t)

(setq truncate-lines t)

;; Do not show welcome screen
(setq inhibit-startup-screen t)

;; Highlight current line
(global-hl-line-mode t)

;; Show line number on the left hand side of the code 
(global-display-line-numbers-mode)

;; Show matching parenthesis
(show-paren-mode t)

;; Detailed window title
(setq-default frame-title-format (list "%65b %f"))
(setq-default icon-title-format (list "%b"))

;; Time stamping
(setq  time-stamp-active t          ; do enable time-stamps
       time-stamp-line-limit 70     ; check first 70 buffer lines for Time-stamp:
       time-stamp-format "%Y-%02m-%02d %02H:%02M:%02S (%u)") ; date format
(add-hook 'write-file-hooks 'time-stamp)

;; Show line and column number in mode line
(column-number-mode t)
(line-number-mode t)

;; Show time in mode line
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time-mode t)

(use-package which-key
  :config
  (which-key-mode t))

(use-package org
  ;; :ensure org-plus-contrib
  ;; :ensure org-tempo
  :custom 
  ;; Tab keeps indenting in src blocks
  (org-src-tab-acts-natively t)
  ;; IDO for completion when applicable
  (org-completion-use-ido t)
  ;; hide emphasis markers
  ;;  (org-hide-emphasis-markers t)
  :config
  ;; (require 'org-tempo)
  (add-hook 'org-mode-hook 
            (lambda ()
              (setq org-file-apps
                    '(("org" . emacs)
                      ("rs"  . emacs)
                      ("c"   . emacs)
                      ("h"   . emacs)
                      )))))

(setq initial-major-mode 'org-mode)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(add-to-list 'org-structure-template-alist
             '("el" . "src emacs-lisp"))

;; TODO: org agenda
;; (setq org-log-done 'time)
;; (setq org-enforce-todo-dependencies t)
;; (setq org-enforce-todo-checkbox-dependencies t)
;; (setq org-todo-keywords
;;       '((sequence "TODO" "WAITING" "|" "DONE")))
;; (setq org-directory "~/documents/org")

;; (defun org-file-path (filename)
;;   "Return the absolute address of an org file, given its relative name."
;;   (concat (file-name-as-directory org-directory) filename))

;; (setq org-index-file (org-file-path "index.org"))
;; (setq org-archive-location
;;       (concat (org-file-path "archive.org") "::* From %s"))
;; (setq org-agenda-files (list org-index-file
;;                              "~/.emacs.d/configuration.org"
;;                              (org-file-path "work.org")
;;                              (org-file-path "archive.org"))) ; Just in case I forget to mark a subtask as done and archive the main one
;; (defun hrs/mark-done-and-archive ()
;;   "Mark the state of an org-mode item as DONE and archive it."
;;   (interactive)
;;   (org-todo 'done)
;;   (org-archive-subtree))

;; (define-key org-mode-map (kbd "C-c C-x C-s") 'hrs/mark-done-and-archive)
;; (setq org-agenda-start-on-weekday nil)
;; (setq org-agenda-span 15)
;; (setq org-agenda-custom-commands
;;       '(("a" "Agenda"
;;          (
;;           (agenda ""  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))))
;;           (alltodo "" ((org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled 'deadline 'todo 'done))))
;;           ))))
;; (setq org-capture-templates
;;       '(("f" "Finished book"
;;          table-line (file "~/Documents/org/books-read.org")
;;          "| %^{Title} | %^{Author} | %u |")

;;         ("t" "Todo"
;;          entry
;;          (file+headline org-index-file "Tâches")
;;          "* TODO %?\n:PROPERTIES:\nCREATED: %u\n:END:\n")

;;         ("b" "Bookmarks"
;;          table-line (file "~/Documents/org/bookmarks.org")
;;          "| %^{prompt|rust|other} | %^{url} | %^{what}")


;;         ("c" "Cycling"
;;          table-line (file "~/Documents/org/cycling.org")
;;          "| %t | balade | %^{prompt|standard|électrique} | %^{Distance} |")

;;         ("w" "Cycling to work"
;;          table-line (file "~/Documents/org/cycling.org")
;;          "| %t | boulot | %^{prompt|électrique|standard} | 26.2 |")))
;; (use-package org-tree-slide
;;   :config
;;   (define-key org-mode-map (kbd "<f8>") 'org-tree-slide-mode)
;;   )
;; ;; Add Beamer to export list
;; (require 'ox-beamer)
;; ;; And markdown
;; (require 'ox-md)

;; ;; some HTML slide export engines
;; (use-package ox-html5slide)
;; (use-package ox-impress-js)
;; (use-package ox-reveal)     
;; (use-package ox-spectacle )

;; ;; bootstrap html
;; (use-package ox-twbs)
;; ;; Configure ox-latex to export source block using minted
;; ;; Setting minted cache to false as cache seems to fail when changing the output-directory
;; (add-to-list 'org-latex-packages-alist '("cache=false" "minted"))
;; (setq org-latex-listings 'minted)

;; (setq org-latex-pdf-process
;;       '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
;; (use-package htmlize)
;; (use-package gnuplot)
;; (use-package gnuplot-mode)
;; (use-package ob-rust)

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((emacs-lisp . t)
;;    (C . t)
;;    (latex . t)
;;    (gnuplot . t)
;;    (dot . t)
;;    (java . t)
;;    (python . t)
;;    (makefile . t)
;;    (org . t)
;;    (perl . t)
;;    (sed . t)
;;    (shell . t)
;;    (rust . t)
;;    ))
;; (setq org-src-preserve-indentation t)
;; (setq org-confirm-babel-evaluate nil)
;; (use-package graphviz-dot-mode)
;; (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))
;; (setq org-export-with-smart-quotes t)
;; (setq org-babel-python-command "python3")
;; (setq org-babel-min-lines-for-block-output 10)

(use-package company
  ;; TODO: ERROR
  ;; :ensure company-lsp 
  :ensure company-box
  :ensure company-php 
  :ensure company-web 
  :init
  (global-company-mode t)
  (global-set-key (kbd "M-/") 'company-complete)
  ;; Complete quite soon
  :custom
  (company-minimum-prefix-length 3)
  (company-idle-delay 0.1)
  (company-show-quick-access "off")  
  (company-quick-access-hint-function (lambda (param) " unknown"))
  )

(use-package company-box
  :ensure frame-local
  :hook (company-mode . company-box-mode))

(use-package treemacs
  :custom
  (treemacs--icon-size 16)
  :bind ("C-c t" . treemacs-select-window)
  )

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode t))

(use-package treemacs-projectile)

(use-package yasnippet
  :init
  (yas-global-mode))
(use-package yasnippet-snippets)

;; TODO:
;; https://gitlab.univ-lille.fr/michael.hauspie/emacs/-/blob/master/configuration.org
;; Developpement - LSP


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(auto-compile use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
