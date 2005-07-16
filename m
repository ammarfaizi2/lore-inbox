Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVGPNTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVGPNTT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 09:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVGPNTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 09:19:19 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:62091 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261549AbVGPNTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 09:19:17 -0400
From: Fabio Erculiani <fabio.erculiani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: strange boot problem since 2.6.12
Date: Sat, 16 Jul 2005 15:19:10 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507161519.10660.fabio.erculiani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is simple and I have it since 2.6.12 final (tested on 2.6.12, 
2.6.12.2, 2.6.13-rc3). After grub stage2 (kernel image loaded) the system 
freeze and I can only hit the three-finger-salute (ctrl+alt+del).

The system is:
Asus A8V Deluxe bios 1014.007 (tested with 1014.001 and 1013)
AMD Athlon 64 3800+ running in 32bit mode
2 GB of DDR PC3200
nVIDIA GF FX 5600XT 256Mb
3 HD (1 ATA and 2 SATA)
etc etc
and it's running mail, web, ldap, ftp and NX services

Here's some info:

cmdline -> http://lxnay.no-ip.org/kernel/bug-report/cmdline
cpuinfo -> http://lxnay.no-ip.org/kernel/bug-report/cpuinfo
lspci -> http://lxnay.no-ip.org/kernel/bug-report/lspci
grub configuration -> http://lxnay.no-ip.org/kernel/bug-report/grub
lsusb -> http://lxnay.no-ip.org/kernel/bug-report/lsusb
kernel config (for 2.6.12 and 2.6.13-rc - make oldconfig) -> 
http://lxnay.no-ip.org/kernel/bug-report/config
Error image -> http://lxnay.no-ip.org/kernel/bug-report/boot.jpg (thanks to 
kdebluetooth and nokia 6600 :-) )

Yes, I'm running 2.6.12, in fact, after hours of recompilations I was able to 
generate a running kernel (based on 2.6.12.2)...
Every 2.6.11 works fine, this is the only one working 2.6.12 and I don't know 
why it works...

Unfortunately, I can't give any more information since the error appears in an 
early stage... :(
-- 
Fabio Erculiani
lxnay
fabio.erculiani@gmail.com - lxnay@lxnaydesign.net
