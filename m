Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSFKVdb>; Tue, 11 Jun 2002 17:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSFKVda>; Tue, 11 Jun 2002 17:33:30 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:56501 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S315276AbSFKVd2>; Tue, 11 Jun 2002 17:33:28 -0400
Message-ID: <20020611213324.19589.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Wed, 12 Jun 2002 05:33:24 +0800
Subject: [2.5.21] compile error
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I've just tried to compile the 2.5.21,
but I got these errors:

make[2]: Entering directory `/usr/src/linux-2.5.21/drivers/ide'
  gcc -Wp,-MD,.ataraid.o.d -D__KERNEL__ -I/usr/src/linux-2.5.21/include -Wall -W
  strict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -
  fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix
   include -DMODULE -include /usr/src/linux-2.5.21/include/linux/modversions.h   -
   DKBUILD_BASENAME=ataraid -DEXPORT_SYMTAB  -c -o ataraid.o ataraid.c
   ataraid.c: In function `ataraid_make_request':
   ataraid.c:101: dereferencing pointer to incomplete type
   ataraid.c:99: warning: `minor' might be used uninitialized in this function
   ataraid.c: In function `ataraid_get_bhead_R1616d035':
   ataraid.c:119: sizeof applied to an incomplete type
   ataraid.c: In function `ataraid_end_request_R6a133f58':
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
   ataraid.c:189: warning: passing arg 1 of `generic_make_request_R3b6085bd' makes
   pointer from integer without a cast
   ataraid.c:189: too many arguments to function `generic_make_request_R3b6085bd'
   ataraid.c:190: warning: passing arg 1 of `generic_make_request_R3b6085bd' makes
   pointer from integer without a cast
   ataraid.c:190: too many arguments to function `generic_make_request_R3b6085bd'
   ataraid.c: In function `ataraid_init':
   ataraid.c:266: warning: passing arg 2 of `blk_queue_make_request_R49fe4a71' from
    incompatible pointer type
    make[2]: *** [ataraid.o] Error 1
    make[2]: Leaving directory `/usr/src/linux-2.5.21/drivers/ide'
    make[1]: *** [_subdir_ide] Error 2
    make[1]: Leaving directory `/usr/src/linux-2.5.21/drivers'
    make: *** [drivers] Error 2

gcc version 2.96 20000731 (Mandrake Linux 8.1 2.96-0.62mdk))

Let me know if you need further information and, please cc' me because I'm not a subscriber of the list.

Many thanks,

-- PC
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
