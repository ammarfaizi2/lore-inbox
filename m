Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315028AbSDWC2G>; Mon, 22 Apr 2002 22:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315029AbSDWC2F>; Mon, 22 Apr 2002 22:28:05 -0400
Received: from web10404.mail.yahoo.com ([216.136.130.96]:9996 "HELO
	web10404.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315028AbSDWC2D>; Mon, 22 Apr 2002 22:28:03 -0400
Message-ID: <20020423022803.17124.qmail@web10404.mail.yahoo.com>
Date: Tue, 23 Apr 2002 12:28:03 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Odd floppy behavior in 2.4.19-pre7-ac1
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I found the problem when building my own floppy boot
disks. I use syslinux build disk 1 using the kernel
and disk 2 the root file system, The kernel has
evrything needed (fd driver built in, etc..;) and
usally it works no problem until I use 2.4.19-pre7-ac1
today.

Put the disk1, boot, it loads the kernel, when it
finished loading from floppy, the light in the floppy
is off, If I remove the floppy and after finishing
everything, the light in the floppy drive lits again
the I saw the messeage like:  Floppy ... I/O error...,
then the light is off;  then it asks to insert the
root disk. I insert the root disk and everything goes
fine.

But if I still put the disk 1 in the drive, of course
no I/O error message. It still asks to insert the root
floppy after the light lits and off. I remove the
disk1 ; put the second one, It says: RAM disk image
found at .... (as usuall) but it only read the floppy
aout 2 seconds, then stop reading. The light nos is
off and the kernel just stay at this forever, no
panic, no ooop .......

In short if I remove disk 1 immediately after it
finished loading the kernel ; there will be an error
message that it can not read from floppy and ask to
insert the root disk, and it goes as normal.

If I remain the disk1 until the kernel asks me to put
the root floppy disk, no error message ; but the
kernel can not or never finish loading  the root disk.

Any one has the similar problem?

If more information ; pls email me

Regards,




=====
Steve Kieu

http://messenger.yahoo.com.au - Yahoo! Messenger
- A great way to communicate long-distance for FREE!
