Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292796AbSBZUUz>; Tue, 26 Feb 2002 15:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293380AbSBZUUp>; Tue, 26 Feb 2002 15:20:45 -0500
Received: from mail.sonytel.be ([193.74.243.200]:20694 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S293378AbSBZUUg>;
	Tue, 26 Feb 2002 15:20:36 -0500
Date: Tue, 26 Feb 2002 21:19:46 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BK Kernel Hacking HOWTO
In-Reply-To: <20020226113402.K12832@lynx.adilger.int>
Message-ID: <Pine.GSO.4.21.0202262117380.8085-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Andreas Dilger wrote:
> On Feb 26, 2002  18:45 +0100, Geert Uytterhoeven wrote:
> > So what if Linus isn't happy with the changes you made in the for-Him-to-pull
> > tree? How do I back off (part of the changes)?
> 
> Well, assuming he tells you that there is a problem, run "bk undo -r <rev>.."
> to remove the patchset that he doesn't like (in theory).  If there have been
> a large number of changes after <rev> then they are all removed (there is no
> way to remove only a single CSET from within the middle of the tree.  Then
> you re-do the changes in a way that Linus likes, and submit a new CSET.
> 
> You could also add the fix to the same tree and hope he accepts both CSETs,
> but I think Linus doesn't want to clutter up his tree with <patch>+<fix>
> instead of a single <patch> that was correct in the first place.
> 
> In some cases, you are probably better off to export the changes in <rev>
> into a diff, get a new Linus BK tree, and re-apply the patches + fixes
> and generate a new CSET from that.
> 
> Not perfect, but that's life.

So in case he wants a few csets only, I have to redo my for-Him-to-pull-tree.
In which case I don't see any advantages compared to emailing a patch with
changeset- and file-specific comments. Especially since setting up a
for-Him-to-pull-tree requires setting up a publically accessible BK server.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

