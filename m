Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275119AbRJFPmF>; Sat, 6 Oct 2001 11:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRJFPl4>; Sat, 6 Oct 2001 11:41:56 -0400
Received: from [213.97.199.90] ([213.97.199.90]:1152 "HELO fargo")
	by vger.kernel.org with SMTP id <S275119AbRJFPli>;
	Sat, 6 Oct 2001 11:41:38 -0400
From: davidge@jazzfree.com
Date: Sat, 6 Oct 2001 17:39:18 +0200 (CEST)
X-X-Sender: <huma@fargo>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: UDF errors
Message-ID: <Pine.LNX.4.33.0110061734510.567-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel is 2.4.9.
It looks i have something really broken in my kernel. First some ext2
errors and now i can't mount a dvd disc.
This is what i get if i try to execute the command:
mount -t udf /dev/dvd /mnt/dvd

Oct  6 17:34:14 fargo kernel: UDF-fs DEBUG lowlevel.c:57:udf_get_last_session: XA disk: no, vol_desc_start=0
Oct  6 17:34:14 fargo kernel: UDF-fs DEBUG super.c:1410:udf_read_super: Multi-session=0
Oct  6 17:34:14 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:14 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:14 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 4607392
Oct  6 17:34:14 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:14 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:14 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 4606368
Oct  6 17:34:14 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:14 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:14 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 4606144
Oct  6 17:34:14 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:14 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:14 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 4607384
Oct  6 17:34:14 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:14 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:14 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 4606360
Oct  6 17:34:14 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:14 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:15 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 4606136
Oct  6 17:34:15 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:15 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:15 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 4606792
Oct  6 17:34:15 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:15 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 4605768
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 4605544
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 4606784
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 4605760
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 4605536
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 3780440
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 3779416
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 3779192
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 3780432
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 3779408
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 3779184
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 3779840
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 3778816
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 3778592
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 3779832
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 3778808
Oct  6 17:34:16 fargo kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Oct  6 17:34:16 fargo kernel: hdb: command error: error=0x50
Oct  6 17:34:16 fargo kernel: end_request: I/O error, dev 03:40 (hdb), sector 3778584
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:1419:udf_read_super: Lastblock=0
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:410:udf_vrs: Starting at sector 16 (2048 byte sectors)
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:437:udf_vrs: ISO9660 Primary Volume Descriptor found
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:446:udf_vrs: ISO9660 Volume Descriptor Set Terminator found
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:760:udf_load_pvoldesc: recording time 940355282/0, 1999/10/19 10:48 (1e5c)
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:770:udf_load_pvoldesc: volIdent[] = 'MATRIX'
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:777:udf_load_pvoldesc: volSetIdent[] = '27535601'
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:961:udf_load_logicalvol: Partition (0:0) type 1 on volume 1
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:971:udf_load_logicalvol: FileSet found in LogicalVolDesc at block=0, partition=0
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:807:udf_load_partdesc: Searching map: (0 == 0)
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:881:udf_load_partdesc: Partition (0:0 type 1511) starts at physical 656, block length 4074540
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:1210:udf_load_partition: Using anchor in block 256
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:732:udf_find_fileset: Fileset at block=0, partition=0
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG super.c:793:udf_load_fileset: Rootdir at block=2, partition=0
Oct  6 17:34:16 fargo kernel: UDF-fs INFO UDF 0.9.4.1-ro (2001/06/13) Mounting volume 'MATRIX', timestamp 1999/10/19 19:48 (1078)
Oct  6 17:34:16 fargo kernel: UDF-fs DEBUG partition.c:40:udf_get_pblock: block=2, partition=0, offset=0: invalid partition
Oct  6 17:34:16 fargo kernel: udf: udf_read_inode(ino 658) failed !bh
Oct  6 17:34:16 fargo kernel: UDF-fs: Error in udf_iget, block=2, partition=0



