Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUBVDtt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 22:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbUBVDts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 22:49:48 -0500
Received: from web10407.mail.yahoo.com ([216.136.130.99]:42821 "HELO
	web10407.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261669AbUBVDtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 22:49:42 -0500
Message-ID: <20040222034938.1016.qmail@web10407.mail.yahoo.com>
Date: Sun, 22 Feb 2004 14:49:38 +1100 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: 2.6.3-mjb1  vmware modules compile error..
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040222011344.GB7483@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,


bash-2.05b# make      
Unable to find VMware installation database. Using
'vmware'.
Building for VMware Workstation 3.2.0.
Using 2.6.x kernel build system.
make -C /lib/modules/2.6.1-mm4/build/include/..
SUBDIRS=$PWD SRCROOT=$PWD/. modu
les
make[1]: Entering directory `/vol/hdb5/linux'
*** Warning: Overriding SUBDIRS on the command line
can cause
***          inconsistencies
make[2]: `arch/i386/kernel/asm-offsets.s' is up to
date.
  CHK     include/asm-i386/asm_offsets.h
  CC [M]  /root/vmmon-6/linux/driver.o
driver.c:7:27: driver-config.h: No such file or
directory
driver.c:23:29: linux/malloc.h: No such file or
directory
driver.c:41:20: vmware.h: No such file or directory
In file included from driver.c:42:
driver.h:9:26: inclu

deCheck.h: No such file or directory
driver.h:14:21: machine.h: No such file or directory
driver.h:15:19: vmx86.h: No such file or directory
driver.h:16:21: vm_time.h: No such file or directory
driver.h:17:29: compat_spinlock.h: No such file or
directory
driver.h:18:25: compat_wait.h: No such file or
directory
driver.h:19:19: vmx86.h: No such file or directory
In file included from driver.c:42:
driver.h:36: error: parse error before "VA"
driver.h:36: warning: no semicolon at end of struct or
unionmake[2]: *** Deletin
g file `/root/vmmon-6/linux/driver.o'
make[2]: *** [/root/vmmon-6/linux/driver.o] Interrupt
make[1]: *** [/root/vmmon-6] Interrupt
make: *** [vmmon.ko] Interrupt

The strange thing is in Makefile.kernel it has the
line
INCLUDE := -I$(SRCROOT)/include -I$(SRCROOT)/common
-I$(SRCROOT)/linux

I just extract the vmmon.tar from the vmware-any---
package and run make in the source dir. It works with
all vanila kernels and mm tree, but not with mjb1.

Thanks for your reply


=====
S.KIEU

Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com
