Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbUJ1T31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbUJ1T31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbUJ1T30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:29:26 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:9200 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261858AbUJ1T3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:29:13 -0400
Date: Thu, 28 Oct 2004 12:28:24 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
Subject: Re: [patch 7/7] uml: resolve symbols in back-traces
Message-ID: <20041028192824.GC851@taniwha.stupidest.org>
References: <200410272223.i9RMNj921852@mail.osdl.org> <200410282034.21922.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410282034.21922.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 08:34:21PM +0200, Blaisorblade wrote:

> And removing the final Emacs comment is not welcome (I don't care,
> but Jeff does. If that should be removed, that's a separate
> problem).

the emacs comments are gratuitous and completely pointless, they serve
no useful purpose.  fwiw in my .emacs i have:

    (defun cw-linux-c-mode ()
      "C mode with adjusted defaults for use with the Linux kernel."
      (interactive)
      (c-mode)
      (c-set-style "linux"))
    (setq auto-mode-alist
	  (append '(("wk/linux.*/.*\\.[ch]$" . cw-linux-c-mode))
		  '(("/usr/src/linux.*/.*\\.[ch]$" . cw-linux-c-mode))
		  auto-mode-alist))

which actually could be cleaned up a bit (it's been hacked over the
years and never cleaned up suitably) but the idea is pretty simple


  --cw

