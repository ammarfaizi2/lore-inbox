Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbTFNLEs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 07:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265664AbTFNLEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 07:04:47 -0400
Received: from web20508.mail.yahoo.com ([216.136.226.143]:41889 "HELO
	web20508.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265654AbTFNLEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 07:04:45 -0400
Message-ID: <20030614111834.477.qmail@web20508.mail.yahoo.com>
Date: Sat, 14 Jun 2003 04:18:34 -0700 (PDT)
From: Ravi Kumar Munnangi <munnangi_ivar@yahoo.com>
Subject: kernel panic:I have no root I want to scream
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Iam using Redhat linux 2.4.18-14(which came with
installing RHlinux-8.0.
Now I want to reconfigure  the kernel.

I have download the linux 2.4.18 from ftp:kernel.org

Ihave put the file in /home/cs0205/
There itself I unzipped the file.
Then I saw a new directory /home/cs0205/linux
then cd /home/cs0205/linux
make mrproper
make xconfig
  During the configuration I havn't made any changes
to 
   the default configuration.I have just saved the 
   default configuration and exited.
make dep
make clean
make bzImage
make modules
make modules_install
make install
  After this I observed that there are new files in 
  /boot like vmlinuz-2.4.18 and vmlinuz-2.4.18.img
  Before there were files named vmlinuz-2.4.18-14 and
  vmlinuz-2.4.18-14.img
  
 I have then changed my /etc/lilo.conf file as follows
  prompt
timeout=50
default=linux_new
boot=/dev/hda
map=/boot/map
install=/boot/boot.b
message=/boot/message
linear

image=/boot/vmlinuz-2.4.18-14
        label=linux
        initrd=/boot/initrd-2.4.18-14.img
        read-only
        append="hdb=ide-scsi root=LABEL=/"
image=/boot/vmlinuz-2.4.18
        label=linux_new
        initrd=/boot/initrd-2.4.18.img
        read-only
        append="hdb=ide-scsi root=LABEL=/"


other=/dev/hda1
        optional
        label=DOS

I have run /sbin/lilo
when I tried booting with the new kernel image, its
stopping after giving the message,
kernel panic:I have no root I want to scream

please help me!!!!!!!!!

Dear friends,
  Iam new to linux.
  I don't know why we should do make mrproper,dep
clean
   bzImage,etc.
  What is the result of this make?
  will u please suggest any resources on net?
  or any text book?
  
  I have read somewhere saying that we have to copy
the 
  bzImage in linux/arch/boot/ to /boot/
  I have also seen something regarding System.map!

  What does this System.map and bzImage contain?
  Do I really have to copy them?
  Then what is the use of make install?
  
 please answer to my queries!!!!!!
  Thankyou!
 for reading the mail patiently!


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
