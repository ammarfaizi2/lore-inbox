Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTD2Qg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 12:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTD2Qg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 12:36:56 -0400
Received: from ulima.unil.ch ([130.223.144.143]:5250 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id S262037AbTD2Qgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 12:36:54 -0400
Date: Tue, 29 Apr 2003 18:49:13 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: no ZIP (250) with 2.4.21-rc1-ac3...
Message-ID: <20030429164913.GA10060@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have first tried to boot it with the ZIP in the drive, but without
sucess :-(
Now, I have booted without a disk in the drive, and only got those
errors:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L120AVVA07-0, ATA DISK drive
hdb: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
blk: queue c03d3760, I/O limit 4095Mb (mask 0xffffffff)
hdc: SONY DVD RW DRU-500A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=15017/255/63, UDMA(100)
hdb: attached ide-scsi driver.
hdc: attached ide-scsi driver.
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
 hdb:<3>ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 0
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 2
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 4
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 6
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 0
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 2
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 4
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 6
 unable to read partition table
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
...
SCSI device sdb: 71687370 512-byte hdwr sectors (36704 MB)
 /dev/scsi/host0/bus0/target15/lun0: p1 p2
sdc : READ CAPACITY failed.
sdc : status = 0, message = 00, host = 0, driver = 28 
Current sd00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x12 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00 0x00 0x00 0xff 0xfe 0x01 0x03 0x31 0x01 0xce 0x5a 
sdc : block size assumed to be 512 bytes, disk size 1GB.  
 /dev/scsi/host2/bus0/target0/lun0: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table

I have an MSI Max2-BLR.

I don't know which other info I should send for this problem?

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
