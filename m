Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbRLJRyh>; Mon, 10 Dec 2001 12:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286341AbRLJRy1>; Mon, 10 Dec 2001 12:54:27 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:3600 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S286333AbRLJRyN>; Mon, 10 Dec 2001 12:54:13 -0500
Date: Mon, 10 Dec 2001 12:53:28 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: Pavel Machek <pavel@suse.cz>
cc: Cory Bell <cory.bell@usa.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
In-Reply-To: <20011210170405.B24663@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0112101240180.15280-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Pavel Machek wrote:

> > I've updated my bios on my Pavilion N5430 and guess what is shows on
> > the bios boot screen (if you disable the bios splash screen)... Omnibook
> > XE3.  They are one in the same, at least model number wise.  weird,
> > considering there are no AMD omnibooks..
>
> I *do* have AMD omnibook on my table.

Err.. that's weird, as if you look in HP's page, the Omnibook XE3 is
listed as Pentium3/Celeron w/ the i830MG chipset only.  However, the
pictures of it show the casing to be almost identical to my N5430.  But, i
don't doubt that you have one.. just an interesting observation.

> Interrupts are not comming. If I hook it on irq11 (usb), and make usb
> generate interrupts, it plays.

My apologies, i misunderstood what you were saying before..  As an
additional data point, one person who tried my origional USB hack (moving
it to IRQ 11) also reported possible problems with PCMCIA not working
anymore... this isn't my experience however.  Also note that the Trident
BladeXP is also on IRQ11, not that linux should care.

Also, the N5425, and N5415 are -newer- revisions of the origional N5430
and N5470 HP Athlon based notebooks... so it's not exactly a 1:1
correlation... I'm also guessing the XE3 is not the same revision as
either of the origional ones (I have an N5430).

Also, I'm running BIOS rev GD1.08 (it shipped with GD1.03, and i tried
GD1.06 when it came out).. what is everyone else running?

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


