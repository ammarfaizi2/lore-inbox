Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263078AbRFANwd>; Fri, 1 Jun 2001 09:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263522AbRFANwN>; Fri, 1 Jun 2001 09:52:13 -0400
Received: from isolaweb.it ([213.82.132.2]:27911 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S263078AbRFANwC>;
	Fri, 1 Jun 2001 09:52:02 -0400
Message-Id: <5.1.0.14.2.20010601153759.00a31550@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 01 Jun 2001 15:49:26 +0200
To: linux-kernel@vger.kernel.org
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: HDD Errors ?!
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

today I found this in my /var/log/messages:

Jun  1 05:26:47 radius kernel: hda: read_intr: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Jun  1 05:26:47 radius kernel: hda: read_intr: error=0x40 { 
UncorrectableError }, LBAsect=25358813, sector=25165970
Jun  1 05:26:47 radius kernel: end_request: I/O error, dev 03:06 (hda), 
sector 25165970
Jun  1 05:26:47 radius kernel: EXT2-fs error (device ide0(3,6)): 
ext2_read_inode: unable to read inode block - inode=1570229, block=3145746
Jun  1 05:26:53 radius kernel: hda: read_intr: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Jun  1 05:26:53 radius kernel: hda: read_intr: error=0x40 { 
UncorrectableError }, LBAsect=25358813, sector=25165970
Jun  1 05:26:53 radius kernel: end_request: I/O error, dev 03:06 (hda), 
sector 25165970
Jun  1 05:26:53 radius kernel: EXT2-fs error (device ide0(3,6)): 
ext2_write_inode: unable to read inode block - inode=1570229, block=3145746
Jun  1 05:27:18 radius kernel: hda: read_intr: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Jun  1 05:27:18 radius kernel: hda: read_intr: error=0x40 { 
UncorrectableError }, LBAsect=25096667, sector=24903824
Jun  1 05:27:18 radius kernel: end_request: I/O error, dev 03:06 (hda), 
sector 24903824
Jun  1 05:27:18 radius kernel: EXT2-fs error (device ide0(3,6)): 
ext2_read_inode: unable to read inode block - inode=1553880, block=3112978
Jun  1 05:27:23 radius kernel: hda: read_intr: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Jun  1 05:27:23 radius kernel: hda: read_intr: error=0x40 { 
UncorrectableError }, LBAsect=25096667, sector=24903824
Jun  1 05:27:23 radius kernel: end_request: I/O error, dev 03:06 (hda), 
sector 24903824
Jun  1 05:27:23 radius kernel: EXT2-fs error (device ide0(3,6)): 
ext2_write_inode: unable to read inode block - inode=1553880, block=3112978

It's a disk error or a FS error ? What can I do to fix the problem ? I 
500Km distant from this machine :-(
and I want made some check remotely before reboot it.

Any suggestion ?

Thanks in advance.


Roberto Fichera.

