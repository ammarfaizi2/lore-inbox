Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSLVNgg>; Sun, 22 Dec 2002 08:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSLVNgg>; Sun, 22 Dec 2002 08:36:36 -0500
Received: from vador.skynet.be ([195.238.3.236]:42862 "EHLO vador.skynet.be")
	by vger.kernel.org with ESMTP id <S261451AbSLVNgf>;
	Sun, 22 Dec 2002 08:36:35 -0500
Message-Id: <200212221344.gBMDiZm12752@vador.skynet.be>
Date: Sun, 22 Dec 2002 14:44:34 +0100 (CET)
From: Helmut Jarausch <jarausch@skynet.be>
Reply-To: jarausch@skynet.be
Subject: Re: [2.4.21-p2] more VIA-IDE problems
To: linux-kernel@vger.kernel.org
cc: john@grabjohn.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote

> > beginning with 2.4.21-pre1 the kernel disables DMA on my
> > regular ATA harddrives.
> >
> > Upto 2.4.20 (Uniform Multi-Platform E-IDE driver Revision: 6.31)
> > there have never been any problems, now I get
> >
> > ! Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > ! VP_IDE: IDE controller at PCI slot 00:04.1
> > VP_IDE: chipset revision 16
> > VP_IDE: not 100% native mode: will probe irqs later
> > VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
> > ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
> > ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
> > hda: Maxtor 94098H6, ATA DISK drive
> > hdb: LITEON DVD-ROM LTD122, ATAPI CD/DVD-ROM drive
> > + hda: DMA disabled
> > + blk: queue c0395e20, I/O limit 4095Mb (mask 0xffffffff)
> > + hdb: DMA disabled
> > hdc: ST340823A, ATA DISK drive
> > hdd: R/RW 4x4x32, ATAPI CD/DVD-ROM drive
> > + hdc: DMA disabled
> > + blk: queue c039626c, I/O limit 4095Mb (mask 0xffffffff)
> > + hdd: DMA disabled
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> 
> I think that they are superflous debugging messages, and that DMA is
> 
> actually re-enabled silently afterwards. I could be wrong, though.

I have to check again, but a preliminary stress test (bonnie++)
shows 95 % cpu usage.

Helmut.

-- 
Helmut Jarausch

Lehrstuhl fuer Numerische Mathematik
RWTH - Aachen University
D 52056 Aachen, Germany
