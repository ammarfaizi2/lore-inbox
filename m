Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLFVsx>; Wed, 6 Dec 2000 16:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbQLFVso>; Wed, 6 Dec 2000 16:48:44 -0500
Received: from ruddock-207.caltech.edu ([131.215.90.207]:42756 "EHLO
	agard.caltech.edu") by vger.kernel.org with ESMTP
	id <S129231AbQLFVsa>; Wed, 6 Dec 2000 16:48:30 -0500
Message-ID: <3A2EACE3.3D4BD3C2@its.caltech.edu>
Date: Wed, 06 Dec 2000 13:17:23 -0800
From: James Lamanna <jlamanna@its.caltech.edu>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with PDC202xx driver
In-Reply-To: <Pine.LNX.4.10.10012061124400.21407-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So you are saying that the Promise Fasttrak 100 chipset is
designed wrong? Because that's exactly what I have.
and isn't this driver supposed to support it?
Or are you saying the IDE controller on the MB is wrong?

Andre Hedrick wrote:
> 
> <4>ide: Assuming 33MHz system bus speed for PIO modes
> <4>AMD7409: IDE controller on PCI bus 00 dev 39
> <4>AMD7409: chipset revision 7
> <4>AMD7409: not 100% native mode: will probe irqs later
> <4>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
> <4>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> <4>PDC20267: IDE controller on PCI bus 00 dev 48
> <4>PDC20267: chipset revision 2
> <4>PDC20267: not 100% native mode: will probe irqs later
> <4>PDC20267: ROM enabled at 0xe8000000
> <4>PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
> <4>    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:DMA, hdf:pio
> <4>    ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:DMA, hdh:pio
> <4>hda: QUANTUM FIREBALL CX13.0A, ATA DISK drive
> <4>hdb: QUANTUM FIREBALL CR4.3A, ATA DISK drive
> <4>hdc: ATAPI CD ROM DRIVE 50X MAX, ATAPI CDROM drive
> <4>hde: Maxtor 91536H2, ATA DISK drive
> <4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> <4>ide1 at 0x170-0x177,0x376 on irq 15
> <4>ide2 at 0xc400-0xc407,0xc802 on irq 11
> 
> Nope you have a chipset that is designed wrong.
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
