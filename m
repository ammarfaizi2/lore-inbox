Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319528AbSIMFks>; Fri, 13 Sep 2002 01:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319529AbSIMFks>; Fri, 13 Sep 2002 01:40:48 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:27141 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S319528AbSIMFkq>; Fri, 13 Sep 2002 01:40:46 -0400
Date: Fri, 13 Sep 2002 07:45:26 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: strange 'DMA disabled' message in 2.4.20-pre5-ac6
Message-ID: <20020913054526.GB510@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is that 'hda: DMA disabled' message in my boot messages? Further on
DMA is enabled on hda - I don't understand what this message means.

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
PDC20265: IDE controller at PCI slot 00:09.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20265: FORCING BURST BIT 0x00->0x01 ACTIVE
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:DMA
HPT370: IDE controller at PCI slot 00:0e.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0xe000-0xe007, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xe008-0xe00f, BIOS settings: hdk:DMA, hdl:pio
hda: Maxtor 33073H3, ATA DISK drive
hda: DMA disabled
blk: queue c03b2940, I/O limit 4095Mb (mask 0xffffffff)
hde: IBM-DTLA-307045, ATA DISK drive
blk: queue c03b3268, I/O limit 4095Mb (mask 0xffffffff)
hdg: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
hdi: Maxtor 4G120J6, ATA DISK drive
blk: queue c03b3b90, I/O limit 4095Mb (mask 0xffffffff)
hdk: Maxtor 4G120J6, ATA DISK drive
blk: queue c03b4024, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xac00-0xac07,0xb002 on irq 16
ide3 at 0xb400-0xb407,0xb802 on irq 16
ide4 at 0xd000-0xd007,0xd402 on irq 18
ide5 at 0xd800-0xd807,0xdc02 on irq 18
hda: host protected area => 1
hda: 60032448 sectors (30737 MB) w/2048KiB Cache, CHS=3736/255/63, UDMA(100)
hde: host protected area => 1
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
hdi: host protected area => 1
hdi: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
hdk: host protected area => 1
hdk: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
ide-cd: passing drive hdg to ide-scsi emulation.
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
 hde:<6> [PTBL] [5606/255/63] hde1 hde2
 hdi: hdi1 hdi2
 hdk: hdk1 hdk2 hdk3
SCSI subsystem driver Revision: 1.00

Kind regards,
Jurriaan
-- 
"I suspect that he regrets nothing."
"Not until we catch him, at any rate."
"He'll regret getting caught," said Scharde. "No doubt as to that."
	Jack Vance - Araminta Station
GNU/Linux 2.4.20-pre5-ac6 SMP/ReiserFS 2x1402 bogomips load av: 0.37 0.14 0.05
