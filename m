Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbTAZQvU>; Sun, 26 Jan 2003 11:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266792AbTAZQvT>; Sun, 26 Jan 2003 11:51:19 -0500
Received: from web20507.mail.yahoo.com ([216.136.226.142]:40278 "HELO
	web20507.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266736AbTAZQvS>; Sun, 26 Jan 2003 11:51:18 -0500
Message-ID: <20030126170034.30209.qmail@web20507.mail.yahoo.com>
Date: Sun, 26 Jan 2003 09:00:34 -0800 (PST)
From: sundara raman <sundararamand@yahoo.com>
Subject: doubts in INIT - while system booting up
To: Linux-Kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got some error while reconfiguring & rebooting the
kernel(version 2.4.7-10) in the Redhat linux 7.2 for
DiffServ support.

I followed the steps for reconfiguring & rebuilding
the kernel. 

1) I downloaded kernel-source-2.4.7-10.rpm from the
internet.
2) After extracting, i got the "Linux" folder in
/usr/src path.
3) I edited the following commands in /usr/src/linux
path

	#make xconfig
	#make dep
	#make clean
	#nohup make bzImage
	#make modules
	#make modules_install
	#cp /usr/src/linux/arch/i386/boot/bzImage
/boot/linix-ds
	
4) I added the "lilo.conf" file in /etc path like
	
	image=/boot/linux-ds
	label=DiffServ
	read-only
	root=/dev/hda6

5) I run "/sbin/lilo" file.
6) after rebooting the system,lilo shows the DiffServ
label.
7) I selected that label.
8) while system booting up, it shows the following
error

	 INIT: Id "x" respawing too fast: disabled for 5
minutes


Please help me.
what will i do?


Best Reagrds
D.SUndara Raman
	


=====
------------------------
D. Sundara Raman
150 Ettayapuram Road
Kovilpatti, Tamilnadu
India. 628 501.
Phone : 04632 - 27267
sundararamand@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
