Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUIMCCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUIMCCi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 22:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUIMCCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 22:02:37 -0400
Received: from web51602.mail.yahoo.com ([206.190.38.207]:27247 "HELO
	web51602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264915AbUIMCCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 22:02:35 -0400
Message-ID: <20040913020235.21673.qmail@web51602.mail.yahoo.com>
Date: Sun, 12 Sep 2004 19:02:35 -0700 (PDT)
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
cp arch/i386/boot/bzImage /boot/bzImage-2.4.26
cp System.map /boot/System.map-2.4.26

and in grub.conf I typed :

title kernel 2.4.26
kernel /boot/vmlinuz-xxx

when I reboot I received a error as follow:

Booting "kernel 2.4.26"
kernel /boot/vmlinuz-2.4.26
Error 15 : File not found 

Can any one help me !
Thanks you very much for help !



		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
