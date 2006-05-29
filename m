Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWE2KiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWE2KiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 06:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWE2KiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 06:38:19 -0400
Received: from ns2.suse.de ([195.135.220.15]:41944 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750832AbWE2KiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 06:38:18 -0400
From: Neil Brown <neilb@suse.de>
To: Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org
Date: Mon, 29 May 2006 20:38:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17530.53001.678650.199391@cse.unsw.edu.au>
Subject: Re: [PATCH] 2.6.16.18 - spelling fix
Newsgroups: gmane.linux.kernel
In-Reply-To: message from Neil Brown on Monday May 29
References: <Pine.LNX.4.64.0605272016520.28903@p34>
	<17530.11036.427239.812677@cse.unsw.edu.au>
	<17530.42626.693182.834140@gargle.gargle.HOWL>
	<17530.45127.92580.684010@cse.unsw.edu.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 29, neilb@suse.de wrote:
> 
> So I guess I need to tell font-lock that all the different text types
> should be displayed in the same font.
> 
> Why is it never easy?

Well, it's not that hard.

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(global-font-lock-mode t nil (font-lock))
 '(show-trailing-whitespace t))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(font-lock-builtin-face ((((class color) (background light)) nil)))
 '(font-lock-comment-face ((((class color) (background light)) nil)))
 '(font-lock-constant-face ((((class color) (background light)) nil)))
 '(font-lock-function-name-face ((((class color) (background light)) nil)))
 '(font-lock-keyword-face ((((class color) (background light)) nil)))
 '(font-lock-string-face ((((class color) (background light)) nil)))
 '(font-lock-type-face ((((class color) (background light)) nil)))
 '(font-lock-variable-name-face ((((class color) (background light)) nil))))

The bold-red for trailing white space is possibly a little too much
... but maybe that is a good thing?

Maybe I'll make feewer typoes now.

NeilBrown

