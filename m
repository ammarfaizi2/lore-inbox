Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTGTIfY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 04:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTGTIfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 04:35:24 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:50191
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263590AbTGTIfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 04:35:14 -0400
Date: Sun, 20 Jul 2003 01:43:01 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Stef van der Made <svdmade@planet.nl>, linux-kernel@vger.kernel.org
Subject: Re: Onstream DI-30 not responding 2.6
In-Reply-To: <Pine.SOL.4.30.0307171938370.20577-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.10.10307200142170.21266-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Would help but my DI-30 is deadlocked and will not function regardless :-(
It is nothing but a paperweight now.

Andre Hedrick
LAD Storage Consulting Group

On Thu, 17 Jul 2003, Bartlomiej Zolnierkiewicz wrote:

> 
> Hi,
> 
> ide-tape driver is broken right now in 2.6.
> Config option for it is commented out because
> it even doesn't compile (easy to fix).
> 
> I can help a bit if somebody wants to fix this driver.
> --
> Bartlomiej
> 
> On Thu, 17 Jul 2003, Stef van der Made wrote:
> >
> > Hi
> >
> > I'm trying to use my Onstream DI-30 (IDE) tape device with Kernel
> > 2.6.0-test1. When trying to access the drive using the old 2.2 kernels
> > and 2.4 these commands worked fine
> >
> > bash-2.05# mt -f /dev/nht0 status
> > /dev/nht0: No such device
> > bash-2.05# mt -f /dev/ht0 status
> > /dev/ht0: No such device
> > bash-2.05# mt -f /dev/hdd status
> > /dev/hdd: No such device or address
> > bash-2.05# mt -f /dev/hdc status
> > /dev/hdc: No such device or address
> >
> > While they now are showing ugly errors.
> >
> > This is a part of the boot log
> >
> > VP_IDE: IDE controller at PCI slot 0000:00:07.1
> > VP_IDE: chipset revision 16
> > VP_IDE: not 100% native mode: will probe irqs later
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
> >     ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
> >     ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:DMA
> > hda: WDC WD205BA, ATA DISK drive
> > anticipatory scheduling elevator
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > hdd: OnStream DI-30, ATAPI TAPE drive
> >
> >
> > Thanks in advance for any tips on a solution for this problem.
> >
> > Stef
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

