Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314557AbSD0CHa>; Fri, 26 Apr 2002 22:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314558AbSD0CH3>; Fri, 26 Apr 2002 22:07:29 -0400
Received: from web10406.mail.yahoo.com ([216.136.130.98]:37125 "HELO
	web10406.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314557AbSD0CH2>; Fri, 26 Apr 2002 22:07:28 -0400
Message-ID: <20020427020728.18534.qmail@web10406.mail.yahoo.com>
Date: Sat, 27 Apr 2002 12:07:28 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: UFS in 2.4.19-pre
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I can not mount a working free bsd file system, with
2.4.19-pre2 and 2.4.19-pre4-ac4  not sure for other
version.

#mount -t ufs /dev/hda6 /mnt/disk/
mount: wrong fs type, bad option, bad superblock on
/dev/hda6,  or too many mounted file systems

Run fdisk

Disk /dev/hda: 255 heads, 63 sectors, 1245 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id 
System
/dev/hda1             1         9     72261   82 
Linux swap
/dev/hda2   *        10       227   1751085    b 
Win95 FAT32
/dev/hda3           228       355   1028160   83 
Linux
/dev/hda4           356      1245   7148925   a5 
BSD/386

Command (m for help):
I tried all mount options, ro, ufstype=44bsd  etc  but
all I got is the same messaage

did anyone see it before? What should I do to read
from this partition from Linux, as u can see this is
the bigest one, and I dont want to delete the whole
freebsd by now, at least until they (freebsd people)
have fixes the i810 audio driver so I can test again.
At the moment I have to boot freebsd to transfer files
from ext2 between...

Thanks in advance.


=====
Steve Kieu

http://messenger.yahoo.com.au - Yahoo! Messenger
- A great way to communicate long-distance for FREE!
