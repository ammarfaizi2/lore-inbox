Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269041AbRH0VWW>; Mon, 27 Aug 2001 17:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269067AbRH0VWM>; Mon, 27 Aug 2001 17:22:12 -0400
Received: from imo-r03.mx.aol.com ([152.163.225.99]:6082 "EHLO
	imo-r03.mx.aol.com") by vger.kernel.org with ESMTP
	id <S269041AbRH0VV6>; Mon, 27 Aug 2001 17:21:58 -0400
From: Floydsmith@aol.com
Message-ID: <b8.1a85f08d.28bc13fa@aol.com>
Date: Mon, 27 Aug 2001 17:22:02 EDT
Subject: 2.4.9 ide-floppy broken - 2.4.8 works ok
To: linux-kernel@vger.kernel.org
CC: Floydsmith@aol.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 4.0 for Windows 95 sub 14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My ls-120 drive is connected to /dev/hdd (a scsi emulated IDE drive is 
connected to /dev/hdc)

The "messages" has:
Aug 27 17:17:28 localhost kernel: hdb: 30043440 sectors (15382 MB) w/2048KiB 
Cache, CHS=1870/255/63
Aug 27 17:17:28 localhost kernel: ide-floppy driver 0.97
Aug 27 17:17:28 localhost kernel: hdd: No disk in drive
Aug 27 17:17:28 localhost kernel: hdd: 123264kB, 963/8/32 CHS, 533 kBps, 512 
sector size, 720 rpm
Aug 27 17:17:28 localhost kernel: ide-floppy: hdd: I/O error, pc = 5a, key =  
5, asc = 24, ascq =  0
Aug 27 17:17:28 localhost kernel: Partition check:
Aug 27 17:17:28 localhost kernel:  hda: hda1 hda2 hda3 hda4 < hda5 >
Aug 27 17:17:28 localhost kernel:  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 >
Aug 27 17:17:28 localhost kernel: ide-floppy driver 0.97

Same message appears when a diskette is attempted to be mounted.

Floyd,
