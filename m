Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274991AbRJAMW4>; Mon, 1 Oct 2001 08:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275000AbRJAMWr>; Mon, 1 Oct 2001 08:22:47 -0400
Received: from CPE-61-9-148-139.vic.bigpond.net.au ([61.9.148.139]:35317 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S274991AbRJAMWg>; Mon, 1 Oct 2001 08:22:36 -0400
Message-ID: <3BB85CE9.586256F3@eyal.emu.id.au>
Date: Mon, 01 Oct 2001 22:09:13 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.9-ac18: DEBUG (ldm.c, 877)?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently moved from 2.4.10 to 2.4.9-ac18 as I just could not handle
the long pauses I get all the time. I noticed this message during
partition check. So what is wrong with basic MS-DOS partitions now?

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:DMA
hda: FUJITSU MPD3084AT, ATA DISK drive
hdb: QUANTUM FIREBALLlct15 20, ATA DISK drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-115 0122, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=1027/255/63,
UDMA(33)
hdb: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=2482/255/63,
UDMA(33)
Partition check:
 hda:<7>LDM:  DEBUG (ldm.c, 877): validate_partition_table: Found basic
MS-DOS p
artition, not a dynamic disk.
 hda1 hda2 < hda5 hda6 hda7 > hda3 hda4
 hdb:<7>LDM:  DEBUG (ldm.c, 877): validate_partition_table: Found basic
MS-DOS p
artition, not a dynamic disk.
 hdb1 hdb2 hdb3 hdb4

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
