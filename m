Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVDYTOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVDYTOb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbVDYTOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:14:30 -0400
Received: from witte.sonytel.be ([80.88.33.193]:35507 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262755AbVDYTNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:13:22 -0400
Date: Mon, 25 Apr 2005 21:12:55 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Jan Dittmer <jdittmer@ppp0.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
In-Reply-To: <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.62.0504252110370.26096@numbat.sonytel.be>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
 <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be>
 <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2005, Al Viro wrote:
> On Thu, Apr 21, 2005 at 11:10:15AM +0200, Geert Uytterhoeven wrote:
> > On Thu, 21 Apr 2005, Jan Dittmer wrote:
> > > Linus Torvalds wrote:
> > > > Geert Uytterhoeven:
> > > >     [PATCH] M68k: Update defconfigs for 2.6.11
> > > >     [PATCH] M68k: Update defconfigs for 2.6.12-rc2
> > > 
> > > Why do I still get this error when trying to cross-compile for m68k?
> > 
> > Because to build m68k kernels, you (still :-( have to use the Linux/m68k CVS
> > repository, cfr. http://linux-m68k-cvs.ubb.ca/.
> > 
> > BTW, my patch queue is at
> > http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.6.x-merging/.
> > The main offender is POSTPONED/156-thread_info.diff.
> 
> I think I have a sane splitup of that stuff.  If you have time to review - yell

Thanks a lot! Very well done!!

I did some (eyeball) review and the compiler liked it as well, so everything
seems OK.

Unfortunately due to various personal reasons I won't have time to test it on
real hardware anytime soon. But if anyone does, I'll take it for sure.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
