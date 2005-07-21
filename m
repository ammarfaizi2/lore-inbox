Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVGUWRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVGUWRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 18:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVGUWRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 18:17:35 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:37017 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261902AbVGUWRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 18:17:33 -0400
From: Fabio Erculiani <fabio.erculiani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: strange boot problem since 2.6.12
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1931
Date: Fri, 22 Jul 2005 00:17:27 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507220017.28106.fabio.erculiani@gmail.com>
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
