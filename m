Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262180AbTCVXkH>; Sat, 22 Mar 2003 18:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbTCVXkH>; Sat, 22 Mar 2003 18:40:07 -0500
Received: from marstons.services.quay.plus.net ([212.159.14.223]:16802 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S262180AbTCVXkF>; Sat, 22 Mar 2003 18:40:05 -0500
Date: Sat, 22 Mar 2003 23:52:14 +0000
From: Robert Murray <rob@mur.org.uk>
To: linux-kernel@vger.kernel.org
Subject: hang during boot with 2.4.19 and an asus a7v
Message-ID: <20030322235213.GH12156@mur.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have an Asus a7v motherboard, 1 gHz athlon.  It was working fine until recently.  The only thing I changed was the sdram speed from 100 to 133. It now hangs after the following messages:

PCI: Using configuration type 1
PCI: Probing PCI hardware
Disabling VIA memory write queue (PCI ID 0305, rev 02): [55] 28 & 1f -> 08
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI Id
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:DMA
hda: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
hdc: Pioneer CD-ROM ATAPI Model DR-944 0107, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-307045, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x8800-0x8807,0x8402 on irq 10
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
ide-cd: passing drive hda to ide-scsi emulation.
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host2/bus0/target0/lun0: [PTBL] [5606/255/63] p1 p2 p3 p4 < p5 p6 p7 >

I did a cmos reset, because I'm blind and can't use the bios setup.  I'm almost 100% sure this changed the sdram speed back to 100 [1], but it still hangs.

Cheers

Rob


[1] The memory speed in memtest86 went back to what it was before I changed to 133.

