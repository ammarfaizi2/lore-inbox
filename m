Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317575AbSFIHMr>; Sun, 9 Jun 2002 03:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317576AbSFIHMq>; Sun, 9 Jun 2002 03:12:46 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:3342 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S317575AbSFIHMp>; Sun, 9 Jun 2002 03:12:45 -0400
Subject: 2.5.21 -- suspend.h:58: parse error before "__nosavedata"
From: Miles Lane <miles@megapathdsl.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 09 Jun 2002 00:10:26 -0700
Message-Id: <1023606626.5775.1.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -Wp,-MD,.suspend.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix include    -DKBUILD_BASENAME=suspend -DEXPORT_SYMTAB  -c -o suspend.o suspend.c
In file included from suspend.c:40:
/usr/src/linux/include/linux/suspend.h:58: parse error before "__nosavedata"
/usr/src/linux/include/linux/suspend.h:58: warning: type defaults to `int' in declaration of `__nosavedata'
/usr/src/linux/include/linux/suspend.h:58: warning: data definition has no type or storage class
/usr/src/linux/include/linux/suspend.h:59: parse error before "__nosavedata"
/usr/src/linux/include/linux/suspend.h:59: warning: type defaults to `int' in declaration of `__nosavedata'
/usr/src/linux/include/linux/suspend.h:59: warning: data definition has no type or storage class
suspend.c:306:2: warning: #warning This might be broken. We need to somehow wait for data to reach the disk
suspend.c: In function `count_and_copy_data_pages':
suspend.c:533: warning: passing arg 1 of `mmx_copy_page' makes pointer from integer without a cast
suspend.c:533: warning: passing arg 2 of `mmx_copy_page' makes pointer from integer without a cast
suspend.c: In function `resume_try_to_read':
suspend.c:1054: warning: unused variable `blksize'
make[1]: *** [suspend.o] Error 1
make[1]: Leaving directory `/usr/src/linux/kernel'

Gnu C                  3.0.4
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.14
e2fsprogs              1.26
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         sr_mod emu10k1 soundcore binfmt_misc ds yenta_socket pcmcia_core autofs 3c59x appletalk ipx ipchains ide-scsi ide-cd cdrom reiserfs nls_iso8859-1 nls_cp437 vfat fat mousedev hid input usb-ohci usbcore ext3 jbd raid0 aic7xxx sd_mod scsi_mod


