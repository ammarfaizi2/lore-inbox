Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTIVEeo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 00:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbTIVEeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 00:34:44 -0400
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:54678 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262771AbTIVEen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 00:34:43 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: linux-kernel@vger.kernel.org
Subject: Warnings when building 2.6.0-test5-bk8 (ntfs, i2c, ide, video, lib)
Date: Mon, 22 Sep 2003 00:34:41 -0400
User-Agent: KMail/1.5.4
References: <1064202544.17769.3.camel@poohbox.perlaholic.com>
In-Reply-To: <1064202544.17769.3.camel@poohbox.perlaholic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309220034.41530.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      fs/ntfs/super.o
fs/ntfs/super.c: In function `is_boot_sector_ntfs':
fs/ntfs/super.c:375: warning: integer constant is too large for "long" type

  CC [M]  drivers/i2c/i2c-sensor.o
drivers/i2c/i2c-sensor.c: In function `i2c_detect':
drivers/i2c/i2c-sensor.c:54: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)

  CC [M]  drivers/ide/ide-tape.o
drivers/ide/ide-tape.c: In function `idetape_setup':
drivers/ide/ide-tape.c:6245: warning: duplicate `const'

  CC      drivers/video/matrox/matroxfb_g450.o
drivers/video/matrox/matroxfb_g450.c: In function `g450_compute_bwlevel':
drivers/video/matrox/matroxfb_g450.c:129: warning: duplicate `const'
drivers/video/matrox/matroxfb_g450.c:130: warning: duplicate `const'

  CC      lib/string.o
lib/string.c:435: warning: conflicting types for built-in function `bcopy'


  AS      arch/i386/boot/setup.o
arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37ffffff

Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.1/specs
Configured with: /var/tmp/portage/gcc-3.3.1-r1/work/gcc-3.3.1/configure --prefix=/usr --bindir=/usr/i686-pc-linux-gnu/gcc-bin/3.3 --includedir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.1/include --datadir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3 --mandir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3/man --infodir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3/info --enable-shared --host=i686-pc-linux-gnu --target=i686-pc-linux-gnu --with-system-zlib --enable-languages=c,c++,ada,f77,objc,java --enable-threads=posix --enable-long-long --disable-checking --enable-cstdio=stdio --enable-clocale=generic --enable-__cxa_atexit --enable-version-specific-runtime-libs --with-gxx-include-dir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.1/include/g++-v3 --with-local-prefix=/usr/local --enable-shared --enable-nls --without-included-gettext --x-includes=/usr/X11R6/include --x-libraries=/usr/X11R6/lib --enable-interpreter --enable-java-awt=xlib --with-x --disable-multilib
Thread model: posix
gcc version 3.3.1 20030904 (Gentoo Linux 3.3.1-r1, propolice)



