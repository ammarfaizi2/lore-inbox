Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSFISv7>; Sun, 9 Jun 2002 14:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314458AbSFISv6>; Sun, 9 Jun 2002 14:51:58 -0400
Received: from smtp05.wxs.nl ([195.121.6.57]:17392 "EHLO smtp05.wxs.nl")
	by vger.kernel.org with ESMTP id <S314451AbSFISv5>;
	Sun, 9 Jun 2002 14:51:57 -0400
Message-ID: <3D03A2D5.BB48CEDE@wxs.nl>
Date: Sun, 09 Jun 2002 20:47:49 +0200
From: Gert Vervoort <Gert.Vervoort@wxs.nl>
Organization: Planet Internet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: "ata_task_file: unknown command 50"
In-Reply-To: <3D0382B7.20306@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel 2.5.21 hangs with repeating the message "ata_task_file: unknown command 50" forever.

more information of my system from 2.5.20 boot log:

Jun  3 20:53:32 viper kernel: ATA/ATAPI device driver v7.0.0
Jun  3 20:53:32 viper kernel: ATA: PCI bus speed 33.3MHz
Jun  3 20:53:32 viper kernel: ATA: Intel Corp. 82371AB PIIX4 IDE, PCI slot 00:07.1
Jun  3 20:53:32 viper kernel: ATA: chipset rev.: 1
Jun  3 20:53:32 viper kernel: ATA: non-legacy mode: IRQ probe delayed
Jun  3 20:53:32 viper kernel: PIIX: Intel Corp. 82371AB PIIX4 IDE UDMA33 controller on pci00:07.1
Jun  3 20:53:32 viper kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
Jun  3 20:53:32 viper kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Jun  3 20:53:32 viper kernel: hda: Maxtor 90845D4, DISK drive
Jun  3 20:53:32 viper kernel: hdb: LITEON DVD-ROM LTD122, ATAPI CD/DVD-ROM drive
Jun  3 20:53:32 viper kernel: hdc: PHILIPS PCA460RW, ATAPI CD/DVD-ROM drive
Jun  3 20:53:32 viper kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun  3 20:53:32 viper kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun  3 20:53:32 viper kernel:  hda: 16514064 sectors w/512KiB Cache, CHS=16383/16/63, UDMA(33)
Jun  3 20:53:32 viper kernel:  hda: [PTBL] [1027/255/63] hda1 hda2 < hda5 hda6 hda7 hda8 >
Jun  3 20:53:32 viper kernel: hdb: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Jun  3 20:53:32 viper kernel: Uniform CD-ROM driver Revision: 3.12
Jun  3 20:53:32 viper kernel: SCSI subsystem driver Revision: 1.00
Jun  3 20:53:32 viper kernel: scsi0 : SCSI host adapter emulation for ATAPI devices
Jun  3 20:53:32 viper kernel:   Vendor: PHILIPS   Model: PCA460RW          Rev: 1.0g
Jun  3 20:53:32 viper kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jun  3 20:53:32 viper kernel: ppa: Version 2.07 (for Linux 2.4.x)
Jun  3 20:53:32 viper kernel: ppa: Found device at ID 6, Attempting to use EPP 16 bit
Jun  3 20:53:32 viper kernel: ppa: Communication established with ID 6 using EPP 16 bit
Jun  3 20:53:32 viper kernel: scsi1 : Iomega VPI0 (ppa) interface
Jun  3 20:53:32 viper kernel:   Vendor: IOMEGA    Model: ZIP 100           Rev: D.13
Jun  3 20:53:32 viper kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun  3 20:53:32 viper kernel: Attached scsi removable disk sda at scsi1, channel 0, id 6, lun 0
Jun  3 20:53:32 viper kernel: sda : READ CAPACITY failed.
Jun  3 20:53:32 viper kernel: sda : status=1, message=00, host=0, driver=08 
Jun  3 20:53:32 viper kernel: Current sd00:00: sense key Not Ready
Jun  3 20:53:32 viper kernel: Additional sense indicates Medium not present
Jun  3 20:53:32 viper kernel: sda : block size assumed to be 512 bytes, disk size 1GB.  
Jun  3 20:53:32 viper kernel:  sda:end_request: I/O error, dev 08:00, sector 0
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 0
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 1
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 2
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 3
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 4
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 5
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 6
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 7
Jun  3 20:53:32 viper kernel: end_request: I/O error, dev 08:00, sector 0
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 0
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 1
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 2
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 3
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 4
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 5
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 6
Jun  3 20:53:32 viper kernel: Buffer I/O error on device sd(8,0), logical block 7
Jun  3 20:53:32 viper kernel:  unable to read partition table
Jun  3 20:53:32 viper kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Jun  3 20:53:32 viper kernel: sr0: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
