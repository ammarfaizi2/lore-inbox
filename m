Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289067AbSAUF6m>; Mon, 21 Jan 2002 00:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289053AbSAUF6C>; Mon, 21 Jan 2002 00:58:02 -0500
Received: from web10801.mail.yahoo.com ([216.136.130.243]:33166 "HELO
	web10801.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289063AbSAUF5K>; Mon, 21 Jan 2002 00:57:10 -0500
Message-ID: <20020121055705.27368.qmail@web10801.mail.yahoo.com>
Date: Sun, 20 Jan 2002 21:57:05 -0800 (PST)
From: yes sure <lm0re@yahoo.com>
Subject: question about building bootable cdrom?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

  I'v made a linux(2.2.16) floppy bootdisk, and it
can boot properly(build with follow commands:
     dd if=bzImage of=/dev/fd0 bs=1k
     rdev /dev/fd0 /dev/fd0
     rdev -R /dev/fd0 
     dd if=rootfs.tgz of=/dev/floppy bs=1k
seek=KERN_SZ
     rdev -r /dev/floppy 1440)
I want to make a bootable cdrom using following
command.
   dd if=/dev/fd0  of=boot.img bs=10k count=144
and I burned the cdrom on windows platform with Nero,
but when I boot with it, I got follow erro message:
   Loading ............................
      
   Out of Memory
   System halted
 
What am i wrong? Any help, a links or any other
message will be great appreciate!!

Thanks in advance!


lm0re

__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
