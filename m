Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSHBQuR>; Fri, 2 Aug 2002 12:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSHBQuR>; Fri, 2 Aug 2002 12:50:17 -0400
Received: from [204.56.6.40] ([204.56.6.40]:39044 "EHLO
	iota.stowers-institute.org") by vger.kernel.org with ESMTP
	id <S316579AbSHBQuR>; Fri, 2 Aug 2002 12:50:17 -0400
Subject: problem compiling 2.5.30
From: Ognen Duzlevski <ogd116@mail.usask.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 02 Aug 2002 11:53:21 -0500
Message-Id: <1028307201.1719.11.camel@iota>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, sorry if this popped up before. It is a redhat 7.3 box, gcc 2.96.
this happens when I include devfs into the kernel.

See below: 

make[2]: Entering directory `/usr/src/linux-2.5.30/fs/partitions' 
  gcc -Wp,-MD,./.check.o.d -D__KERNEL__ -I/usr/src/linux-2.5.30/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=check
-DEXPORT_SYMTAB  -c -o check.o check.c 
check.c: In function `devfs_register_partitions': 
check.c:470: array subscript is not an integer 
make[2]: *** [check.o] Error 1 
make[2]: Leaving directory `/usr/src/linux-2.5.30/fs/partitions' 
make[1]: *** [partitions] Error 2 
make[1]: Leaving directory `/usr/src/linux-2.5.30/fs' 
make: *** [fs] Error 2 

Thanks, 
Ognen 



