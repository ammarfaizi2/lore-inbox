Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbULaEgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbULaEgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 23:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbULaEgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 23:36:00 -0500
Received: from [202.125.86.130] ([202.125.86.130]:42681 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261858AbULaEfo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 23:35:44 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: kernel panic: Attempted to kill init!
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Fri, 31 Dec 2004 10:10:23 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348112B889D@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel panic: Attempted to kill init!
Thread-Index: AcTu77OTS24sFG34QW6ym9EhBpaQTg==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I downloaded the Fedora Core 3 (kernel 2.6.9-1.667) ISO CDs from the
following link. 
http://download.fedora.redhat.com/pub/fedora/linux/core/3/i386/iso/
I burn the CDs. I installed the Fedora Core 3 in an Intel Machine. It
was working fine. 

Now I want to build the 2.6.6 kernel image. Then I downloaded the kernel
tar file from the following link.
http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.6.tar.gz

After that I did the following steps.

1.	I copied the downloaded tar file to the /usr/src directory.
2.	I un tar the downloaded tar file.
3.	I changed the owner to ROOT by 
	#chown -R root:root /usr/src/linux-2.6.6

After this I compiled the kernel by the following steps.

4.	#make menuconfig	-	to creating the config file
5.	#make clean
6.	#make bzImage

Now I changed the EXTRAVERSION in Makefile

7.	#make modules
8.	#make modules_install
9.	#make install	-	this will copy the bzImage file to /boot

					directory and also updates the
menu.list 
					i.e. grub.conf file and copies
System.map file etc.

Every thing goes fine. After rebooting the system through this new
kernel image 
I got the following error messages and system halted.

Red Hat nash version 4.1.18 starting 
Enforcing mode requested but no policy loaded. Halting now. 
Kernel panic: Attempted to kill init!

I succeeded in building the new kernel image, but un succeeded in
booting from the new image. I tried 2 to 3 times. I got the same error.
  
What am I doing wrong here? Please advice me with right one.

Thanks in advance.

Regards,
Srinivas G



