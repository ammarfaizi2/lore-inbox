Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTKQARL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 19:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTKQARL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 19:17:11 -0500
Received: from crete.csd.uch.gr ([147.52.16.2]:54442 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S263228AbTKQARI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 19:17:08 -0500
Organization: 
Date: Mon, 17 Nov 2003 02:16:13 +0200 (EET)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: Andrew Morton <akpm@osdl.org>
cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
In-Reply-To: <20031116134231.763fc5ed.akpm@osdl.org>
Message-ID: <Pine.GSO.4.58.0311170213430.7124@tinos.csd.uch.gr>
References: <20031116192643.GB15439@zip.com.au> <3FB7DCF9.5090205@gmx.de>
 <20031116134231.763fc5ed.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also had problems with -mm3.
Now I am using the latest tree from linus with no problems.

P.S.
Sorry but I have no time to try mm3 with the patch reverted.

	Panagiotis Papadakos

On Sun, 16 Nov 2003, Andrew Morton wrote:

> "Prakash K. Cheemplavam" <prakashpublic@gmx.de> wrote:
> >
> > CaT wrote:
> >
> >  > I just noticed major interactivity problems whilst ogging one of my
> >
>
> "ogging"?
>
> > Going back to mm2 (patched mm2) and everything it fine again.
>
> Two things to try, please:
>
> a) Is the problem from Linus's tree?  Try 2.6.0-test9 plus
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm3/broken-out/linus.patch
>
> b) The only significant scheduler change in mm3 was
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm3/broken-out/context-switch-accounting-fix.patch
>
>    So please try -mm3 with the above patch reverted with
>
> 	patch -R -p1 < context-switch-accounting-fix.patch
>
>
> Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
