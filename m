Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318869AbSHMFsZ>; Tue, 13 Aug 2002 01:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318938AbSHMFrc>; Tue, 13 Aug 2002 01:47:32 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:48541 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318943AbSHMFqg>; Tue, 13 Aug 2002 01:46:36 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre2
Date: Mon, 12 Aug 2002 01:58:19 -0400
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208120158.19207.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[3]: Entering directory `/usr/src/linux-2.4.20-pre2/fs/partitions'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-pre2/include -Wall 
-Wstrict-prototypes                                -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -                               
mpreferred-stack-boundary=2 -march=athlon    -nostdinc -I 
/usr/lib/gcc-lib/athlon-redhat-linux/3.2/include 
-DKBUILD_BASENAME=check  -DEXPORT_SYMTAB -c check.c
check.c: In function `devfs_register_disc':
check.c:328: structure has no member named `number'
check.c:329: structure has no member named `number'
check.c: In function `devfs_register_partitions':
check.c:361: structure has no member named `number'
make[3]: *** [check.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.20-pre2/fs/partitions'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.20-pre2/fs/partitions'
make[1]: *** [_subdir_partitions] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20-pre2/fs'
make: *** [_dir_fs] Error 2
