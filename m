Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279144AbRKICSW>; Thu, 8 Nov 2001 21:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279157AbRKICSL>; Thu, 8 Nov 2001 21:18:11 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:896 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S279144AbRKICSC>; Thu, 8 Nov 2001 21:18:02 -0500
Date: Thu, 8 Nov 2001 19:17:34 -0700
Message-Id: <200111090217.fA92HYh00521@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org
Cc: Andre Hedrick <andre@linux-ide.org>
Subject: Lockup in IDE code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I tried to use my IDE CD-ROM today, the first time in a
long while. When attempting to mount it, the machine locked up,
hard. Even SysReq didn't work. I got the following message:

hdb: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14

I was running 2.4.7 initially, and then pulled down 2.4.14 and got the
same problem. All my IDE drivers are loadable modules. The kernel
messages I get when I load those modules are appended. If I turn off
DMA using hdparm, I don't get a lockup.

This wasn't always a problem. The last time I used my CD-ROM it worked
fine. My motherboard is an Asus P2B-D (dual PIII).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
===============================================================================
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
hdb: CRD-8480B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdb: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdb: set_drive_speed_status: error=0xb4
hdb: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
