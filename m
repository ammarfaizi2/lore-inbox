Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268691AbRHPVL6>; Thu, 16 Aug 2001 17:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268837AbRHPVLs>; Thu, 16 Aug 2001 17:11:48 -0400
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:60581 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S268691AbRHPVLc>; Thu, 16 Aug 2001 17:11:32 -0400
Posted-Date: Thu, 16 Aug 2001 23:06:18 +0100 (WEST)
Date: Thu, 16 Aug 2001 23:11:40 +0200
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200108162111.XAA07177@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9 does not compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've the following error messages :

gcc -D__KERNEL__ -I/usr/src/kernel-sources-2.4.9/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-DMODULE -DMODVERSIONS -include
/usr/src/kernel-sources-2.4.9/include/linux/modversions.h
-DNTFS_VERSION=\"1.1.16\"   -c -o unistr.o unistr.c
unistr.c: In function `ntfs_collate_names':
unistr.c:99: warning: implicit declaration of function `min'
unistr.c:99: parse error before `unsigned'
unistr.c:99: parse error before `)'
unistr.c:97: warning: `c1' might be used uninitialized in this function
unistr.c: At top level:
unistr.c:118: parse error before `if'
unistr.c:123: warning: type defaults to `int' in declaration of `c1'
unistr.c:123: `name1' undeclared here (not in a function)
unistr.c:123: warning: data definition has no type or storage class
unistr.c:124: parse error before `if'
make[3]: *** [unistr.o] Erreur 1
make[3]: Leaving directory `/usr/src/kernel-sources-2.4.9/fs/ntfs'
make[2]: *** [_modsubdir_ntfs] Erreur 2
make[2]: Leaving directory `/usr/src/kernel-sources-2.4.9/fs'
make[1]: *** [_mod_fs] Erreur 2
make[1]: Leaving directory `/usr/src/kernel-sources-2.4.9'
make: *** [stamp-build] Erreur 2


gcc is :
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20010319 (Debian prerelease)

------
Regards
		Jean-Luc
