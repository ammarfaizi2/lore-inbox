Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUFNLWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUFNLWQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 07:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUFNLWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 07:22:16 -0400
Received: from web51609.mail.yahoo.com ([206.190.38.214]:39045 "HELO
	web51609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262406AbUFNLWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 07:22:14 -0400
Message-ID: <20040614112213.40111.qmail@web51609.mail.yahoo.com>
Date: Mon, 14 Jun 2004 04:22:13 -0700 (PDT)
From: ngo giang <ngohoanggiang1981dh@yahoo.com>
Subject: Error when build linux kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello !

I am Ngo Hoang Giang 

I installed Vmware 4.0 for Window , created a virtual
machine and installed RedHat 8.0  as a guest operating
system . I want to built kernel . I used kernel 2.4.3 
and did follow : 

# cp  linux-2.4.3.tar.gz  /home

# cd  /home

# tar zxvf 1inux-2.4.19.tar.gz

# ln -sf  linux-2.4.19  linux

# cd linux

# make menuconfig

# make dep

# make bzImage

but the compilation has error as follow : 

timer.c : 35 conflicting types for ‘xtime’
/home/linux/include/linux/sched.h:540 : previous
declaration of ‘xtime’
make[2] : *** [timer.o] Error 1
make[2] : Leaving directory ‘/home/linux/kernel’
make[1] : *** [first_rule] Error 2
make[1] : Leaving directory ‘/home/linux/kernel’
make :  *** [_dir_kernel ] Error 2

The result is similar when I tried with kernel 2.4.2
Thanks for your help ,
Ngo Hoang Giang



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
