Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbSBKAbQ>; Sun, 10 Feb 2002 19:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285618AbSBKAbG>; Sun, 10 Feb 2002 19:31:06 -0500
Received: from iggy.triode.net.au ([203.63.235.1]:4488 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S285589AbSBKAay>; Sun, 10 Feb 2002 19:30:54 -0500
Date: Mon, 11 Feb 2002 11:30:17 +1100
From: Linux Kernel Mailing List <kernel@iggy.triode.net.au>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALI 15X3 DMA Freeze
Message-ID: <20020211113017.A4461@iggy.triode.net.au>
In-Reply-To: <20020211085956.A23445@iggy.triode.net.au> <Pine.LNX.4.33.0202101817330.31698-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202101817330.31698-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Sun, Feb 10, 2002 at 06:17:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now I have turned off "PNP OS" and fiddled a little with
the boot options. Same basic problem remains, the 
machine compiles the kernel fine with DMA off but freezes
when compiling the kernel with DMA on.

Here are the new boot messages:

Regards.  Paul


Kernel command line: auto BOOT_IMAGE=2.4.17.9 ro root=301 BOOT_FILE=/boot/bzImage-2.4.17.9 idebus=66 ide0=ata66 pci=biosirq
ide_setup: idebus=66
ide_setup: ide0=ata66

PCI: PCI BIOS revision 2.10 entry at 0xf1170, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 66MHz system bus speed for PIO modes
ALI15X3: IDE controller on PCI bus 00 dev 20
PCI: No IRQ known for interrupt pin A of device 00:04.0.
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
ALI15X3: ATA-66/100 forced bit set (WARNING)!!
    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:pio, hdd:DMA
hda: IC35L040AVER07-0, ATA DISK drive
hdb: CDU5211, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63
hdb: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2


On Sun, Feb 10, 2002 at 06:17:56PM -0500, Mark Hahn wrote:
> > PCI: No IRQ known for interrupt pin A of device 00:04.0.
> 
> are you sure you don't have the bios set for "PNP OS"?
