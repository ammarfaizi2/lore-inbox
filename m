Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbSKBPQa>; Sat, 2 Nov 2002 10:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbSKBPQa>; Sat, 2 Nov 2002 10:16:30 -0500
Received: from [212.104.37.2] ([212.104.37.2]:41226 "EHLO
	actnetweb.activenetwork.it") by vger.kernel.org with ESMTP
	id <S261258AbSKBPQ2>; Sat, 2 Nov 2002 10:16:28 -0500
Date: Sat, 2 Nov 2002 16:21:43 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [2.5.45] CDRW not working
Message-ID: <20021102152143.GA515@dreamland.darkstar.net>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I can't even mount a cd using my CDRW drive (CD-ROM drive is ok).

I see the following messages:

hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdd: packet command error: error=0x50
end_request: I/O error, dev 16:40, sector 0
end_request: I/O error, dev 16:40, sector 0
hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x50LastFailedSense 0x05 
hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdd: packet command error: error=0x50
end_request: I/O error, dev 16:40, sector 0
end_request: I/O error, dev 16:40, sector 0
hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x50LastFailedSense 0x05 
cdrom: open failed.
hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdd: packet command error: error=0x50
end_request: I/O error, dev 16:40, sector 0
end_request: I/O error, dev 16:40, sector 0
hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x50LastFailedSense 0x05 
hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdd: packet command error: error=0x50
end_request: I/O error, dev 16:40, sector 0
end_request: I/O error, dev 16:40, sector 0
hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x50LastFailedSense 0x05 
hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdd: packet command error: error=0x50
end_request: I/O error, dev 16:40, sector 0
end_request: I/O error, dev 16:40, sector 0
hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x50LastFailedSense 0x05 
cdrom: open failed.
hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdd: packet command error: error=0x50
end_request: I/O error, dev 16:40, sector 0
end_request: I/O error, dev 16:40, sector 0
hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x50LastFailedSense 0x05 
hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdd: packet command error: error=0x50
end_request: I/O error, dev 16:40, sector 0
end_request: I/O error, dev 16:40, sector 0
hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x50LastFailedSense 0x05 
hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdd: packet command error: error=0x50
end_request: I/O error, dev 16:40, sector 0
end_request: I/O error, dev 16:40, sector 0
hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x50LastFailedSense 0x05 
cdrom: open failed.
hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdd: packet command error: error=0x50
end_request: I/O error, dev 16:40, sector 0
end_request: I/O error, dev 16:40, sector 0
hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x50LastFailedSense 0x05 
hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdd: packet command error: error=0x50
end_request: I/O error, dev 16:40, sector 0
end_request: I/O error, dev 16:40, sector 0
hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x50LastFailedSense 0x05 


>From bootlog:
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLlct10 10, ATA DISK drive
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CRD-8520B, ATAPI CD/DVD-ROM drive
hdd: CRW6206A, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
hdd: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=1247/255/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 > p3 p4
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 6X CD-ROM CD-R/RW drive, 512kB Cache, DMA

ciao,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"La mia teoria scientifica preferita e` quella secondo la quale gli 
 anelli di Saturno sarebbero interamente composti dai bagagli andati 
 persi nei viaggi aerei." -- Mark Russel
