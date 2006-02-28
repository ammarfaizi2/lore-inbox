Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWB1ELf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWB1ELf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 23:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWB1ELf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 23:11:35 -0500
Received: from [219.93.96.109] ([219.93.96.109]:65246 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750732AbWB1ELe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 23:11:34 -0500
Subject: make dep -problem
From: xxxx <toxicitycom@gmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Feb 2006 04:09:11 +0000
Message-Id: <1141099751.29028.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** Check the top-level Makefile for additional configuration.
*** Next, you must run 'make dep'.

make[1]: Entering directory `/home/matt/uClinux-workspace/uClinux-dist'
make ARCH=m68knommu CROSS_COMPILE=m68k-elf- -C linux-2.4.x menuconfig
make[2]: Entering directory `/home/matt/uClinux-workspace/uClinux-2.4.x'
rm -f include/asm
( cd include ; ln -sf asm-m68knommu asm)
make -C scripts/lxdialog all
make[3]: Entering directory
`/home/matt/uClinux-workspace/uClinux-2.4.x/scripts/lxdialog'
make[3]: Leaving directory
`/home/matt/uClinux-workspace/uClinux-2.4.x/scripts/lxdialog'
/bin/sh scripts/Menuconfig arch/m68knommu/config.in
Using defaults found in .config
Preparing scripts: functions, parsing../MCmenu0: line 106: unexpected
EOF while looking for matching `''
./MCmenu0: line 110: syntax error: unexpected end of file
......................................................................done.


Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: line 832: MCmenu0: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make[2]: *** [menuconfig] Error 1
make[2]: Leaving directory `/home/matt/uClinux-workspace/uClinux-2.4.x'
make[1]: *** [linux_menuconfig] Error 2
make[1]: Leaving directory `/home/matt/uClinux-workspace/uClinux-dist'
make: *** [menuconfig] Error 2
[matt@localhost uClinux-dist]$




