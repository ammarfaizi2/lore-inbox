Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262401AbSJHNMW>; Tue, 8 Oct 2002 09:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262419AbSJHNMW>; Tue, 8 Oct 2002 09:12:22 -0400
Received: from ulima.unil.ch ([130.223.144.143]:2688 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S262401AbSJHNMV>;
	Tue, 8 Oct 2002 09:12:21 -0400
Date: Tue, 8 Oct 2002 15:17:58 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40,41, 41-ac1 no DVD-ROM !!!
Message-ID: <20021008131758.GA2877@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

like already repported for 2.5.40 I can't access my DVD-ROM with
ide-scsi (and poorly without it):

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALL CX13.6A, ATA DISK drive
Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace: [<c0136f1b>]  [<c01ecfd5>]  [<c01ed077>]  [<c01fec09>]  [<c0206580>]  [<c01fee43>]  [<c0206940>]  [<c01ff2c8>]  [<c01feaf6>]  [<c02106fe>]  [<c01fdd97>]  [<c010507d>]  [<c0105040>]  [<c0105675>] 
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Pioneer DVD-ROM ATAPIModel DVD-103S 011, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace: [<c0136f1b>]  [<c01ecfd5>]  [<c01ed077>]  [<c01fec09>]  [<c0206580>]  [<c01fee43>]  [<c0206940>]  [<c01ff2c8>]  [<c01feaf6>]  [<c021071d>]  [<c01fdd97>]  [<c010507d>]  [<c0105040>]  [<c0105675>] 
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
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 0 lun 0
register interface 'mouse' with class 'input

as all files are to be found under http://ulima.unil.ch/greg/linux/
and that I have already repported it, I won't give more unless spefically
demanded ;-))

cdrecord -scanbus don't find anything...

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
