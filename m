Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262231AbSJJJHR>; Thu, 10 Oct 2002 05:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263330AbSJJJHQ>; Thu, 10 Oct 2002 05:07:16 -0400
Received: from ulima.unil.ch ([130.223.144.143]:8832 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S262231AbSJJJHP>;
	Thu, 10 Oct 2002 05:07:15 -0400
Date: Thu, 10 Oct 2002 11:13:00 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40-ac2: the come back of my DVD-ROM ;-)
Message-ID: <20021010091300.GA2874@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

just booted it and:

cdrecord -scanbus
Cdrecord 1.11a26 (i586-mandrake-linux-gnu) Copyright (C) 1995-2002 Jörg
Schilling
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.6'
scsibus0:
cdrecord: Warning: controller returns wrong size for CD capabilities page.
	0,0,0	  0) 'PIONEER ' 'DVD-ROM DVD-103 ' '1.16' Removable CD-ROM

And I can mount cdrom again with it!!!

Even if at boot:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALL CX13.6A, ATA DISK drive
Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace: [<c01376db>]  [<c01f0745>]  [<c01f07d7>]  [<c0202409>]  [<c0209e00>]  [<c020263d>]  [<c020a1b0>]  [<c0202ab8>]  [<c02022f4>]  [<c0214070>]  [<c0201626>]  [<c010507a>]  [<c0105040>]  [<c0105665>] 
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Pioneer DVD-ROM ATAPIModel DVD-103S 011, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace: [<c01376db>]  [<c01f0745>]  [<c01f07d7>]  [<c0202409>]  [<c0209e00>]  [<c020263d>]  [<c020a1b0>]  [<c0202ab8>]  [<c02022f4>]  [<c021408f>]  [<c0201626>]  [<c010507a>]  [<c0105040>]  [<c0105665>] 
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 26760384 sectors (13701 MB) w/418KiB Cache, CHS=1665/255/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2
ide-floppy driver 0.99.newide
hdd: 244766kB, 489532 blocks, 512 sector size
hdd: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
hdd: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
hdd: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
 /dev/ide/host0/bus1/target1/lun0: unknown partition table
 /dev/ide/host0/bus1/target1/lun0: unknown partition table
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: transferred 47 of 48 bytes
  Vendor: PIONEER   Model: DVD-ROM DVD-103   Rev: 1.16
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12

Great!!!

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
