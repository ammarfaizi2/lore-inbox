Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316877AbSFDWKY>; Tue, 4 Jun 2002 18:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSFDWKW>; Tue, 4 Jun 2002 18:10:22 -0400
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:12555 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S316877AbSFDWKC>; Tue, 4 Jun 2002 18:10:02 -0400
Message-Id: <5.1.0.14.2.20020605000918.00cb74f8@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 05 Jun 2002 00:10:40 +0200
To: linux-kernel@vger.kernel.org
From: system_lists@nullzone.org
Subject: PROBLEMS to compile ataraid.c in kernel-2.5.20
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i got this error messages trying to get mi ataraid hardware on.

can any help me please? i have the system stoped waiting for this.

Seeya


gcc -D__KERNEL__ -I/usr/src/linux-2.5.20-ct2/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686    -DKBUILD_BASENAME=ataraid -DEXPORT_SYMTAB -c -o ataraid.o 
ataraid.c
ataraid.c: In function `ataraid_make_request':
ataraid.c:101: dereferencing pointer to incomplete type
ataraid.c:99: warning: `minor' might be used uninitialized in this function
ataraid.c: In function `ataraid_get_bhead':
ataraid.c:119: sizeof applied to an incomplete type
ataraid.c: In function `ataraid_end_request':
ataraid.c:143: dereferencing pointer to incomplete type
ataraid.c:149: dereferencing pointer to incomplete type
ataraid.c: In function `ataraid_split_request':
ataraid.c:172: dereferencing pointer to incomplete type
ataraid.c:172: dereferencing pointer to incomplete type
ataraid.c:172: dereferencing pointer to incomplete type
ataraid.c:173: dereferencing pointer to incomplete type
ataraid.c:173: dereferencing pointer to incomplete type
ataraid.c:173: dereferencing pointer to incomplete type
ataraid.c:175: dereferencing pointer to incomplete type
ataraid.c:176: dereferencing pointer to incomplete type
ataraid.c:178: dereferencing pointer to incomplete type
ataraid.c:178: dereferencing pointer to incomplete type
ataraid.c:179: dereferencing pointer to incomplete type
ataraid.c:180: dereferencing pointer to incomplete type
ataraid.c:183: dereferencing pointer to incomplete type
ataraid.c:184: dereferencing pointer to incomplete type
ataraid.c:187: dereferencing pointer to incomplete type
ataraid.c:187: dereferencing pointer to incomplete type
ataraid.c:189: warning: passing arg 1 of `generic_make_request' makes 
pointer from integer without a cast
ataraid.c:189: too many arguments to function `generic_make_request'
ataraid.c:190: warning: passing arg 1 of `generic_make_request' makes 
pointer from integer without a cast
ataraid.c:190: too many arguments to function `generic_make_request'
ataraid.c: In function `ataraid_init':
ataraid.c:266: warning: passing arg 2 of `blk_queue_make_request' from 
incompatible pointer type
make[2]: *** [ataraid.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.20-ct2/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.20-ct2/drivers'
make: *** [drivers] Error 2



