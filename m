Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbSJYKWT>; Fri, 25 Oct 2002 06:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSJYKWT>; Fri, 25 Oct 2002 06:22:19 -0400
Received: from imo-d03.mx.aol.com ([205.188.157.35]:52463 "EHLO
	imo-d03.mx.aol.com") by vger.kernel.org with ESMTP
	id <S261218AbSJYKWS>; Fri, 25 Oct 2002 06:22:18 -0400
Date: Fri, 25 Oct 2002 06:31:02 -0400
From: Floydsmith@aol.com
To: linux-kernel@vger.kernel.org
Cc: floydsmith@aol.com
Subject: 2.4.18 iomega 250 zip won't mount - wrong size
MIME-Version: 1.0
Message-ID: <28FF45A5.05264F2B.0B512FEB@aol.com>
X-Mailer: Atlas Mailer 2.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

With 2.4.18 while trying to mount and mk a fs on a IOMEGA 250Meg zip drive I got.
localhost.localdomain:/# mount -t vfat /dev/hdc /mnt
hdc: The disk reports a capacity of 250640384 bytes, but the drive only handles
250609664
FAT: bogus logical sector size 8293
VFS: Can't find a valid FAT filesystem on dev 16:00.
mount: wrong fs type, bad option, bad superblock on /dev/hdc,
       or too many mounted file systems
hdc: The disk reports a capacity of 250640384 bytes, but the drive only handles
250609664


localhost.localdomain:/# mkfs -t vfat /dev/hdc
mkfs.vfat 2.8 (28 Feb 2001)
hdc: The disk reports a capacity of 250640384 bytes, but the drive only handles
250609664
hdc: The disk reports a capacity of 250640384 bytes, but the drive only handles
250609664
mkfs.vfat: Will not try to make filesystem on '/dev/hdc'
localhost.localdomain:/#

>From dmede0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c03135a4, I/O limit 4095Mb (mask 0xffffffff)
hda: 26564832 sectors (13601 MB) w/2048KiB Cache, CHS=1653/255/63, UDMA(33)
blk: queue c03136f0, I/O limit 4095Mb (mask 0xffffffff)
hdb: 30043440 sectors (15382 MB) w/2048KiB Cache, CHS=1870/255/63, UDMA(33)
ide-floppy driver 0.99.newide
hdc: 244766kB, 489532 blocks, 512 sector size
hdc: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
hdc: The disk reports a capacity of 250640384 bytes, but the drive only handles
250609664
Partition check:

Any sugestions?

Floyd,


