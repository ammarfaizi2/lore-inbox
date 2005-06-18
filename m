Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVFRKrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVFRKrb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 06:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVFRKrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 06:47:31 -0400
Received: from mail.dif.dk ([193.138.115.101]:39377 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262099AbVFRKrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 06:47:03 -0400
Date: Sat, 18 Jun 2005 12:52:21 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Willy Tarreau <willy@w.ods.org>, Linus Torvalds <torvalds@osdl.org>,
       Keith Owens <kaos@ocs.com.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12
In-Reply-To: <200506181448.34181.adobriyan@gmail.com>
Message-ID: <Pine.LNX.4.62.0506181250590.2653@dragon.hyggekrogen.localhost>
References: <21446.1119073126@ocs3.ocs.com.au> <20050618065911.GH8907@alpha.home.local>
 <Pine.LNX.4.62.0506181231410.2653@dragon.hyggekrogen.localhost>
 <200506181448.34181.adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2005, Alexey Dobriyan wrote:

> On Saturday 18 June 2005 14:36, Jesper Juhl wrote:
> > --- linux-2.6.12-orig/Documentation/dontdiff
> > +++ linux-2.6.12/Documentation/dontdiff
> > @@ -138,3 +138,4 @@
> >  wanxlfw.inc
> >  uImage
> >  zImage
> > +pax_global_header
> 
> In alphabetic order, please.
> 
Ok.

Add pax_global_header to Documentation/dontdiff
Kernel tar-archives created by git contain an extended header with the git
commit ID that was used to generate the tar-tree. If your tar is older
than 1.14 then this extended header will be extracted as a regular file
called pax_global_header. Patches should never be generated against this
file, so it should be listed in dontdiff.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 Documentation/dontdiff |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.12-orig/Documentation/dontdiff	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/Documentation/dontdiff	2005-06-18 12:49:50.000000000 +0200
@@ -115,6 +115,7 @@
 oui.c*
 parse.c*
 parse.h*
+pax_global_header
 pnmtologo
 ppc_defs.h*
 promcon_tbl.c*



