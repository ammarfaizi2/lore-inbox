Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281007AbRKLVYL>; Mon, 12 Nov 2001 16:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281010AbRKLVYB>; Mon, 12 Nov 2001 16:24:01 -0500
Received: from johnson.mail.mindspring.net ([207.69.200.177]:28476 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S281007AbRKLVXp>; Mon, 12 Nov 2001 16:23:45 -0500
From: joeja@mindspring.com
Date: Mon, 12 Nov 2001 16:23:39 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.9 to 2.4.14 bug & workaround
Message-ID: <Springmail.105.1005600219.0.18983900@www.springmail.com>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an internal iomega 'type' (not iomega) IDE zip drive.  It mounts as /dev/hdd instead of /dev/hdd4.  Mounting as /dev/hdd seems okay.

Mounting as /dev/hdd4 will hang my kernel( 2.4.9-2.4.14).  I have read that on some MB you can change the bios to none for the ide device and this works on certain mb.  I tried this and it did not change anything.

MB is ABIT KT7A.  

Bug, some disks will mount as /dev/hdd4 if you try.  This seems to have erratic behavior as sometimes you will have no problems, othertimes it will tell you you have mounted Read only even though mount show rw.  If you copy large files to the drive (38 to 50 meg backups) you may have it hang in the middle of cp.

you can eject the disk from the drive, you cannot kill cp, you cannot properly shutdown system as there are messages about hdd umount failing and this just hangs the system and becomes unusable.

Workaround seems to be mount as /dev/hdd.  This seems wrong though.  

Reproducability is often.

Joe

