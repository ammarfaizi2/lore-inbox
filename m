Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282192AbRK1XzZ>; Wed, 28 Nov 2001 18:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282196AbRK1XzO>; Wed, 28 Nov 2001 18:55:14 -0500
Received: from walden.phpwebhosting.com ([64.65.61.214]:19475 "HELO
	walden.phpwebhosting.com") by vger.kernel.org with SMTP
	id <S282192AbRK1Xy5>; Wed, 28 Nov 2001 18:54:57 -0500
Message-Id: <5.1.0.14.0.20011128173852.00a28440@sunset.olemiss.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 28 Nov 2001 17:55:11 -0600
To: linux-kernel@vger.kernel.org
From: Ben Pharr - Lists <ben-lists@benpharr.com>
Subject: IDE SeekComplete Error
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been getting a DriveReady SeekComplete Error at bootup from my CD 
burner. Below are the excerpts from dmesg. I have a script that turns off 
DMA on the writer, but it hasn't been reached yet when this error occurs. 
This occurred on my first boot of 2.4.17-pre1, but I'm not positive it 
hasn't been happening with earlier kernels. I doesn't seem to be causing 
any problems.

Ben Pharr


Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALLlct15 20, ATA DISK drive
hdc: SAMSUNG DVD-ROM SD-612, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG CD-R/RW SW-408B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=2482/255/63, UDMA(33)
hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
  hda: hda1 hda2 hda4

SCSI subsystem driver Revision: 1.00
hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdd: set_drive_speed_status: error=0x04
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: SAMSUNG   Model: CD-R/RW SW-408B   Rev: BS02
   Type:   CD-ROM                             ANSI SCSI revision: 02

