Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284617AbRLDAUu>; Mon, 3 Dec 2001 19:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282993AbRLDASb>; Mon, 3 Dec 2001 19:18:31 -0500
Received: from 24.213.60.124.up.mi.chartermi.net ([24.213.60.124]:12487 "EHLO
	front2.chartermi.net") by vger.kernel.org with ESMTP
	id <S284700AbRLCPpP>; Mon, 3 Dec 2001 10:45:15 -0500
Date: Mon, 3 Dec 2001 09:50:30 -0600 (CST)
From: Cheryl Homiak <chomiak@chartermi.net>
To: linux-kernel@vger.kernel.org
Subject: Via82cxx chipset problem
Message-ID: <Pine.LNX.4.40.0112030943110.223-100000@maranatha.chartermi.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried this question on another list and was told not to try to change my
mhz speed because I would corrupt my hard drive possibly. But does this
mean I am actually running at only 33mhz.? This doesn't seem like a viable
way to run my computer and I am having problems with installing new memory
that may be related to this. My original message is below; any help would
be appreciated.
Thanks.

try here first.
I have a via82c597 rev 4 chipset and an Award bios. I have anabled the
via82cxxx support in my kernel, but perhaps I do not understand what
numbers to put in on the command line, or for which ide to put them in,
because no matter what I do a 33mhz bus speed is assumed; if I try putting
66 even in I get something about this being impossible.
I have included part of my dmesg here, and have included enough so you can
see my setup and a couple of other messages that puzzle me.
Any help would be appreciated.

PCI: PCI BIOS revision 2.10 entry at 0xfb360, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring class.
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe408-0xe40f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST32520A, ATA DISK drive
hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive
hdd: Conner Peripherals 420MB - CFS420A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 4927104 sectors (2523 MB), CHS=4888/16/63, UDMA(33)
hdd: 832608 sectors (426 MB) w/64KiB Cache, CHS=826/16/63, DMA
hdc: ATAPI 24X CD-ROM drive, 120kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12








