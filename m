Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVLRVFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVLRVFk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 16:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVLRVFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 16:05:40 -0500
Received: from piraten.student.lu.se ([130.235.208.46]:53169 "EHLO
	piraten.student.lu.se") by vger.kernel.org with ESMTP
	id S1751180AbVLRVFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 16:05:40 -0500
Date: Sun, 18 Dec 2005 22:05:38 +0100
From: MIHALY BAK <mihaly.bak.021@student.lth.se>
Subject: Unable to handle kernel NULL pointer dereference at ...
To: linux-kernel@vger.kernel.org
Message-id: <42cc6ec42cea67.42cea6742cc6ec@net.lu.se>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 1.14 (built Mar 18 2003)
Content-type: text/plain; charset=us-ascii
Content-language: sv
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: sv
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------
Quick summery:
------------
When I try to run Java Applets with sound inside my 32-bit chroot within a firefox 32-bit I get this the first time:
http://www.student.lu.se/~ihpv03mba/kernel/kernellog
and the applet never loads, the message in the kernel log only apperas the first time.

------------
Full description
------------
I'll just contine from the quick summery...
I am using a 32-bit chroot installtion within my 64-bit installation to run Java Applets from a firefox that I have got within my 32-bit chroot

I installed my 32-bit chroot after this howto:
https://alioth.debian.org/docman/view.php/30192/21/debian-amd64-howto.html#id271998

I have got two soundcards in my system 
1) Creative Soundblaster (Surround speakers, pci-card)
2) Uli/Intel/Realtek, alsamixer says it chip is "Realtek ALC850", I dont really know what it is (headphones, integrated into mainboard)

I normally switch between these during the day but when I have got this error message in the kernellog I cant switch to the creative sound card only the built-in thing works.

All logs are found at
http://www.student.lu.se/~ihpv03mba/kernel/
The files will be here for atleast two years from 2005-12

Kernel version
http://www.student.lu.se/~ihpv03mba/kernel/ver_linux

Processor information
http://www.student.lu.se/~ihpv03mba/kernel/cpuinfo

Modules
http://www.student.lu.se/~ihpv03mba/kernel/modules

/proc/ioports /proc/iomem
http://www.student.lu.se/~ihpv03mba/kernel/iomen-ioports

lspci -vvv
http://www.student.lu.se/~ihpv03mba/kernel/lspci

Java version and chroot mounts
http://www.student.lu.se/~ihpv03mba/kernel/java-fstab

