Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271233AbRHOPuH>; Wed, 15 Aug 2001 11:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271242AbRHOPt5>; Wed, 15 Aug 2001 11:49:57 -0400
Received: from [213.97.199.90] ([213.97.199.90]:1408 "HELO fargo")
	by vger.kernel.org with SMTP id <S271233AbRHOPtn> convert rfc822-to-8bit;
	Wed, 15 Aug 2001 11:49:43 -0400
From: "David =?ISO-8859-1?Q?G=F3mez" ?= <davidge@jazzfree.com>
Date: Wed, 15 Aug 2001 17:49:05 +0200 (CEST)
X-X-Sender: <huma@fargo>
To: <ext3-users@redhat.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: vfat is not working with ext3 patch
Message-ID: <Pine.LNX.4.33.0108151736510.518-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

My system is :
kernel 2.4.8 with ext3-0.9.6 patch
e2fsprogs-1.22-2, mount-2.11g, util-linux-2.11f

And ext3 filesystem works fine, but when a vfat partition is mounted:

[fargo] [~] # mount /dev/hdd1 /mnt/tmp
[fargo] [~] # mount
/dev/hda1 on / type ext2 (rw)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hdd1 on /mnt/tmp type vfat (rw)

everything looks ok till I try to access that partition. A 'cd' to the
directory /mnt/tmp causes an error of 'not a directory' so i can't access
to vfat partition. Switching to the unpatched kernel makes everything work
fine again. I asked Andries but he doesn't think is a mount problem, so
what do you think, is this a problem caused by ext3 patch or by vfat
filesystem ?


Thanks




David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra



