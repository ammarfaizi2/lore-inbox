Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129500AbRBGTMX>; Wed, 7 Feb 2001 14:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBGTMN>; Wed, 7 Feb 2001 14:12:13 -0500
Received: from web12008.mail.yahoo.com ([216.136.172.216]:31507 "HELO
	web12008.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129027AbRBGTMI>; Wed, 7 Feb 2001 14:12:08 -0500
Message-ID: <20010207191207.50272.qmail@web12008.mail.yahoo.com>
Date: Wed, 7 Feb 2001 11:12:07 -0800 (PST)
From: Lourenco <andyrock50@yahoo.com>
Subject: IDE PROBLEM 2.4.0 and 2.4.1 ...
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

i am getting an error every time i try to copy a big
file from my cdrom to one of my harddrives...

my hardware: P2 333 128 MB Ram
             ONLY IDE
             BOARD BX

i had run dmesg.

PS : It works FINE with 2.2.* and other OS's...

here it goes:

...
VFS: Disk change detected on device ide1(22,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
VFS: Disk change detected on device ide1(22,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
isofs_read_level3_size: More than 100 file sections
?!?, aborting...
isofs_read_level3_size: inode=45152 ino=53408
isofs_read_level3_size: More than 100 file sections
?!?, aborting...
isofs_read_level3_size: inode=45232 ino=53488
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18356
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18360
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18364
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18368
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18372
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18376
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18380
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18384
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18388
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18392
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18396
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18400
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18404
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18408
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18412
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18416
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18420
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18424
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18428
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18432
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18436
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18440
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18444
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18448
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18452
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18456
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18460
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18464
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18468
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
end_request: I/O error, dev 16:00 (hdc), sector 18472
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
end_request: I/O error, dev 16:00 (hdc), sector 18476
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
end_request: I/O error, dev 16:00 (hdc), sector 18480
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18484
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18488
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18492
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18468
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18472
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18468
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18472
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18468
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
end_request: I/O error, dev 16:00 (hdc), sector 18472
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18468
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18472



__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices.
http://auctions.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
