Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTFJLjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 07:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTFJLjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 07:39:51 -0400
Received: from web10707.mail.yahoo.com ([216.136.130.215]:51330 "HELO
	web10707.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262148AbTFJLjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 07:39:06 -0400
Message-ID: <20030610115247.55738.qmail@web10707.mail.yahoo.com>
Date: Tue, 10 Jun 2003 04:52:47 -0700 (PDT)
From: BalaKrishna Mallipeddi <bkmallipeddi@yahoo.com>
Subject: Problem while including a module to kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I am in deep trouble to include a module to kernel.

I am getting the following warnings, errors and hints
while compiling(via makefile) and including the
module(via insmod) to kernel. I am including the log
below for easy reference. Please help me. 
log:
root@(none):/home/chois/rfs_modules/fdisk# make
gcc -Wall -DMODULE -D__KERNEL__ -DLINUX -c
rfs_fdisk_module.c
rfs_fdisk_module.c: In function `rfs_fdisk_module':
rfs_fdisk_module.c:374: warning: implicit declaration
of function `ioctl'
rfs_fdisk_module.c:403: warning: implicit declaration
of function
`reboot'root@(none):/home/chois/rfs_modules/fdisk#
sync
root@(none):/home/chois/rfs_modules/fdisk# insmod
rfs_fdisk_module.o
rfs_fdisk_module.o: unresolved symbol read
rfs_fdisk_module.o: unresolved symbol reboot
rfs_fdisk_module.o: unresolved symbol lseek
rfs_fdisk_module.o: unresolved symbol _exit
rfs_fdisk_module.o: unresolved symbol write
rfs_fdisk_module.o: unresolved symbol ioctl
rfs_fdisk_module.o:
Hint: You are trying to load a module without a GPL
compatible license
      and it has unresolved symbols.  Contact the
module supplier for
      assistance, only they can help you.


I had gone through many questions related to this
"Hint". But i couldn't get any generalized answer. All
are related to a particular context.

Thanks & Regards

=====
BalaKrishna Mallipeddi
Member Technical Staff Software
Innomedia Technologies Pvt. Ltd.,
#3278, 12th Main, HAL 2nd stage,
Bangalore-560008,
INDIA
Phone : 5278389 + 123

__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
