Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265723AbTFSHQv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 03:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbTFSHQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 03:16:51 -0400
Received: from [194.242.39.2] ([194.242.39.2]:60667 "EHLO
	mail.sto-procent.art.pl") by vger.kernel.org with ESMTP
	id S265723AbTFSHQq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 03:16:46 -0400
Date: Thu, 19 Jun 2003 09:30:12 +0200 (CEST)
From: boka <boka@sto-procent.art.pl>
To: linux-kernel@vger.kernel.org
Subject: Compile problem with 2.4.21, ac-1, openwall
Message-ID: <Pine.LNX.4.56.0306190928010.6923@testosteron.sto-procent.art.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I`m trying to compile stock 2.4.21 kernel with ac and openwall patches
I have rh9 with all erratas applied. Compilation process ends with the
following error:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.21/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=pentium3   -nostdinc -iwithprefix
include -DKBUILD_BASENAME=swapfile  -c -o swapfile.o swapfile.c
swapfile.c: In function `sys_swapoff':
swapfile.c:797: `victim' undeclared (first use in this function)
swapfile.c:797: (Each undeclared identifier is reported only once
swapfile.c:797: for each function it appears in.)
swapfile.c:799: `tmp' undeclared (first use in this function)
make[2]: *** [swapfile.o] error
d 1
make[2]: Opuszczam katalog `/usr/src/linux-2.4.21/mm'
make[1]: *** [first_rule] error
d 2
make[1]: Opuszczam katalog `/usr/src/linux-2.4.21/mm'
make: *** [_dir_mm] error
d 2

gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.2/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man
--infodir=/usr/share/info --enable-shared --enable-threads=posix
--disable-checking --with-system-zlib --enable-__cxa_atexit
--host=i386-redhat-linux
Thread model: posix
gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)

--
Dziwne to, ale wyborca nigdy nie czuje siê odpowiedzialny za zawód, jaki
sprawia rz±d przez niego wybrany. Alberto Moravia
pozdrawiam boka@sto-procent.art.pl
