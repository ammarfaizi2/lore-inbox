Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUIMInp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUIMInp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 04:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUIMInp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 04:43:45 -0400
Received: from web51603.mail.yahoo.com ([206.190.38.208]:6019 "HELO
	web51603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266425AbUIMInn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 04:43:43 -0400
Message-ID: <20040913084342.62705.qmail@web51603.mail.yahoo.com>
Date: Mon, 13 Sep 2004 01:43:42 -0700 (PDT)
From: ngo giang <ngohoanggiang1981dh@yahoo.com>
Subject: Can not reboot when build kernel 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I want to build kernel to support DiffServ service in
Traffic Control.
 
I did as following 
......
make rmproper
make xconfig
make dep
make clean
make bzImage
make modules
make modules_install
cp arch/i386/boot/bzImage /boot/vmlinuz-2.4.26
cp System.map /boot/System.map-2.4.26

and in grub.conf I typed :

title kernel 2.4.26
kernel /boot/vmlinuz-2.4.26

when I reboot I received a error as follow:

Booting "kernel 2.4.26"
kernel /boot/vmlinuz-2.4.26
Error 15 : File not found 

Can any one help me !
Thanks you very much for help !


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - Helps protect you from nasty viruses.
http://promotions.yahoo.com/new_mail
