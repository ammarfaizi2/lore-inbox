Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbTJDQU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 12:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTJDQU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 12:20:28 -0400
Received: from smtp5.poczta.onet.pl ([213.180.130.32]:40854 "EHLO
	smtp5.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262374AbTJDQU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 12:20:27 -0400
From: Piotr Michniewski <cobra_666@poczta.onet.pl>
Reply-To: cobra_666@poczta.onet.pl
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Cannot mount my Nokia 5510
Date: Sat, 4 Oct 2003 18:19:06 +0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200310041819.07069.cobra_666@poczta.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One line summary of the problem: Cannot mount my Nokia 5510

Full description of the problem:

I have a Nokia 5510 mobile phone. It has a built-in mp3 player with 64 MB of 
memory and connects to the PC via USB. I have compiled support for USB and 
SCSI in modules. When I connect the phone to my PC it gets properly detected 
by Linux and the device /dev/sda1 appears. I cannot mount it though. When I 
type mount -t vfat /dev/sda1 /mnt/nokia, I get an error:

mount: wrong fs type, bad option, bad superblock on /dev/sda1,
       or too many mounted file systems

The phone worked fine with 2.4 kernels just fine. I think it has something 
with the FAT driver (compiled as a module with VFAT support).


Kernel version: Linux version 2.6.0-test6 (root@cobra2) (gcc version 3.3.1 
20030904 (Gentoo Linux 3.3.1-r1, propolice)) #1 Mon Sep 29 19:02:28 CEST 2003

Please CC me because I'm not on the list. Also this is my first report, so 
don't scream too much ;)

-- 
Cobra
