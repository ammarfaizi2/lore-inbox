Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbUJ1VCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbUJ1VCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbUJ1VCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:02:41 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:61546 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263003AbUJ1VBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:01:55 -0400
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: [patch 7/7] uml: resolve symbols in back-traces
Date: Thu, 28 Oct 2004 23:02:48 +0200
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
References: <200410272223.i9RMNj921852@mail.osdl.org> <200410282034.21922.blaisorblade_spam@yahoo.it> <20041028192824.GC851@taniwha.stupidest.org>
In-Reply-To: <20041028192824.GC851@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410282302.48311.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 21:28, Chris Wedgwood wrote:
> On Thu, Oct 28, 2004 at 08:34:21PM +0200, Blaisorblade wrote:
> > And removing the final Emacs comment is not welcome (I don't care,
> > but Jeff does. If that should be removed, that's a separate
> > problem).

> the emacs comments are gratuitous and completely pointless, they serve
> no useful purpose.  fwiw in my .emacs i have:

>     (defun cw-linux-c-mode ()
>       "C mode with adjusted defaults for use with the Linux kernel."
>       (interactive)
>       (c-mode)
>       (c-set-style "linux"))
>     (setq auto-mode-alist
>    (append '(("wk/linux.*/.*\\.[ch]$" . cw-linux-c-mode))
>     '(("/usr/src/linux.*/.*\\.[ch]$" . cw-linux-c-mode))
>     auto-mode-alist))
>
> which actually could be cleaned up a bit (it's been hacked over the
> years and never cleaned up suitably) but the idea is pretty simple

I mostly agree on this, and thought it myself (I *never* use Emacs, only Vim, 
but no flames here).

However, let's be kind with Jeff, since he's the UML maintainer. You can be 
right, but there's also courtesy.

If Jeff says "OK", then someone can submit a separate patch removing all the 
final comments.

Until then, please don't.

And never mix such unrelated changes in a patch.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

