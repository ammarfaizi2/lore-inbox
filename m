Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293380AbSBZUlz>; Tue, 26 Feb 2002 15:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293413AbSBZUlt>; Tue, 26 Feb 2002 15:41:49 -0500
Received: from mail.sonytel.be ([193.74.243.200]:22744 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S293380AbSBZUlj>;
	Tue, 26 Feb 2002 15:41:39 -0500
Date: Tue, 26 Feb 2002 21:40:36 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Larry McVoy <lm@bitmover.com>
cc: Andreas Dilger <adilger@turbolabs.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BK Kernel Hacking HOWTO
In-Reply-To: <20020226122933.C10806@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0202262139180.8085-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Larry McVoy wrote:
> > So in case he wants a few csets only, I have to redo my for-Him-to-pull-tree.
> > In which case I don't see any advantages compared to emailing a patch with
> > changeset- and file-specific comments. Especially since setting up a
> > for-Him-to-pull-tree requires setting up a publically accessible BK server.
> 
> You can set up a publically accessible tree here, if you need one, 
> see the Hosting link on our website.  You can make your tree publically
> accessible in multiple ways, with varying levels of security, see
> "bk help bkd".

OK.

> The advantage of allowing him to pull is that you won't have the same data
> in your BK tree twice, which you would have if you sent him diffs and then
> pulled the diffs from him.  This is ESPECIALLY IMPORTANT if you have renames
> (and creates/deletes are a sort of rename) in your patch.

Yes, that's true.

> If the situation is that you've created a scratch tree, specifically for
> sending stuff to Linus and you aren't going to use it for anything else
> or build on it, then you can send him regular diffs, and toss the tree
> once you know he accepted them.

I guess in most cases we (the m68k boys, who got their CVS tree only a few
months ago ;-)) will end up using this `plan B' anyway...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

