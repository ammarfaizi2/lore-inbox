Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265003AbTFYUL7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265013AbTFYUL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:11:59 -0400
Received: from imf24aec.mail.bellsouth.net ([205.152.59.72]:41912 "EHLO
	imf24aec.bellsouth.net") by vger.kernel.org with ESMTP
	id S265003AbTFYULb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:11:31 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: linux-kernel@vger.kernel.org
Subject: Assorted warnings while building 2.5.73
Date: Wed, 25 Jun 2003 16:25:41 -0400
User-Agent: KMail/1.5.2
References: <20030618013114.A23697@ucw.cz> <16121.55803.509760.869572@napali.hpl.hp.com> <20030625215847.A12212@ucw.cz>
In-Reply-To: <20030625215847.A12212@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306251625.41248.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps I over estimate, but some of these seem of mild concern, primarily the forced conditions.
Does the LKML want to see these, or should I report them via some other mechanism?

fs/fat/inode.c: In function `fat_fill_super':
fs/fat/inode.c:806: warning: comparison is always true due to limited range of data type
fs/ntfs/super.c: In function `is_boot_sector_ntfs':
fs/ntfs/super.c:375: warning: integer constant is too large for "long" type
fs/smbfs/ioctl.c: In function `smb_ioctl':
fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type
fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type
fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type
fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type
drivers/char/vt_ioctl.c: In function `do_kdsk_ioctl':
drivers/char/vt_ioctl.c:85: warning: comparison is always false due to limited range of data type
drivers/char/vt_ioctl.c:85: warning: comparison is always false due to limited range of data type
drivers/char/vt_ioctl.c: In function `do_kdgkb_ioctl':
drivers/char/vt_ioctl.c:211: warning: comparison is always false due to limited range of data type
drivers/char/keyboard.c: In function `k_fn':
drivers/char/keyboard.c:665: warning: comparison is always true due to limited range of data type
drivers/ide/ide-probe.c: In function `hwif_check_region':
drivers/ide/ide-probe.c:644: warning: `check_region' is deprecated (declared at include/linux/ioport.h:116)
drivers/serial/8250.c: In function `serial8250_set_termios':
drivers/serial/8250.c:1428: warning: comparison is always false due to limited range of data type
drivers/video/matrox/matroxfb_g450.c: In function `g450_compute_bwlevel':
drivers/video/matrox/matroxfb_g450.c:129: warning: duplicate `const'
drivers/video/matrox/matroxfb_g450.c:130: warning: duplicate `const'
net/ipv4/igmp.c: In function `igmp_rcv':
net/ipv4/igmp.c:851: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1129)
arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37ffffff
drivers/i2c/i2c-sensor.c: In function `i2c_detect':
drivers/i2c/i2c-sensor.c:54: warning: `check_region' is deprecated (declared at include/linux/ioport.h:116)
drivers/ieee1394/raw1394.c: In function `arm_register':
drivers/ieee1394/raw1394.c:1569: warning: integer constant is too large for "long" type
drivers/ieee1394/raw1394.c:1570: warning: integer constant is too large for "long" type
	
Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3/specs
Configured with: /var/tmp/portage/gcc-3.3/work/gcc-3.3/configure --prefix=/usr --bindir=/usr/i686-pc-linux-gnu/gcc-bin/3.3 --includedir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3/include --datadir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3 --mandir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3/man --infodir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3/info --enable-shared --host=i686-pc-linux-gnu --target=i686-pc-linux-gnu --with-system-zlib --enable-languages=c,c++,ada,f77,objc,java --enable-threads=posix --enable-long-long --disable-checking --enable-cstdio=stdio --enable-clocale=generic --enable-__cxa_atexit --enable-version-specific-runtime-libs --with-gxx-include-dir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3/include/g++-v3 --with-local-prefix=/usr/local --enable-shared --enable-nls --without-included-gettext --x-includes=/usr/X11R6/include --x-libraries=/usr/X11R6/lib --enable-interpreter --enable-java-awt=xlib --with-x
Thread model: posix
gcc version 3.3 (Gentoo Linux 1.4, PVR 3.3)

