Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRCKVfZ>; Sun, 11 Mar 2001 16:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129156AbRCKVfO>; Sun, 11 Mar 2001 16:35:14 -0500
Received: from ohiper1-88.apex.net ([209.250.47.103]:54534 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S129143AbRCKVfD>; Sun, 11 Mar 2001 16:35:03 -0500
Date: Sun, 11 Mar 2001 15:37:52 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Martin Diehl <home@mdiehl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE on 2.4.2
Message-ID: <20010311153752.A29108@hapablap.dyn.dhs.org>
In-Reply-To: <3AA95226.FD878418@ciit.y12.doe.gov> <Pine.LNX.4.21.0103111255150.10784-100000@notebook.diehl.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103111255150.10784-100000@notebook.diehl.home>; from home@mdiehl.de on Sun, Mar 11, 2001 at 10:03:48PM +0100
X-Uptime: 3:27pm  up 1 day,  1:06,  1 user,  load average: 2.03, 1.64, 1.45
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2001 at 10:03:48PM +0100, Martin Diehl wrote:
> On Fri, 9 Mar 2001, Lawrence MacIntyre wrote:
> 
> > Uniform MultiPlatform E-IDE driver Revision 6.31
> > ide: assuminmg 33 MHz system bus speed for PIO modes: override with
> > idebus=xx
> > SIS5513: IDE controller on PCI bus 00 dev 09
> > PCI: Assigned IRQ 14 for device 00:01.1
> > SIS5513: chipset revision 208
> > SIS5513: not 100% native mode: will probe irqs later
> > SIS5597
> >     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
> > hda: Maxtor 90640D4, ATA DISK drive
> > hdc: CD-ROM CDU55E, ATAPI CD/DVD-ROM drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > 
> > At this point, the machine hangs...
> 
> interesting, I see the same thing except it hangs not before the disk
> drives are initialized but afterwards, when initializing the CD-ROM
> drives. (Compiling ide-cd as module permits successful boot but hangs
> on insmod). This is with SiS5513 rev 208 IDE function from SiS5591
> chipset with CONFIG_BLK_DEV_SIS5513 and autotune enabled (default).

I have this exact same chip on my board (a PCChips M599-LMR or something
like that) which works flawlessly on 2.4.2, even with UDMA66.
-- 
-Steven
Never ask a geek why, just nod your head and slowly back away.
