Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbUJ3M1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbUJ3M1L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 08:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbUJ3M1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 08:27:11 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:44929 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261412AbUJ3M1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 08:27:07 -0400
Message-ID: <41838899.6070302@ribosome.natur.cuni.cz>
Date: Sat, 30 Oct 2004 14:27:05 +0200
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041030
X-Accept-Language: cs, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cannot compile 2.4.28-rc1-bk3
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  has someone seen something like this?

gcc -D__KERNEL__ -I/usr/src/linux-2.4.28-rc1-bk3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -nostdinc -iwithprefix include -DKBUILD_BASENAME=neighbour  -c -o neighbour.o neighbour.c
neighbour.c:1901: error: `THIS_MODULE' undeclared here (not in a function)
neighbour.c:1901: error: initializer element is not constant
neighbour.c:1901: error: (near initialization for `neigh_stat_seq_fops.owner')
make[3]: *** [neighbour.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.28-rc1-bk3/net/core'



gcc -v
Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/specs
Configured with: /var/tmp/portage/gcc-3.3.4-r1/work/gcc-3.3.4/configure --prefix=/usr --bindir=/usr/i686-pc-linux-gnu/gcc-bin/3.3 --includedir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/include --datadir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3 --mandir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3/man --infodir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3/info --enable-shared --host=i686-pc-linux-gnu --target=i686-pc-linux-gnu --with-system-zlib --enable-languages=c,c++,f77 --enable-threads=posix --enable-long-long --disable-checking --disable-libunwind-exceptions --enable-cstdio=stdio --enable-version-specific-runtime-libs --with-gxx-include-dir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/include/g++-v3 --with-local-prefix=/usr/local --enable-shared --enable-nls --without-included-gettext --disable-multilib --enable-__cxa_atexit --enable-clocale=generic
Thread model: posix
gcc version 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)


I can provide .config if someone asks. Please Cc: me in replies.
Martin
