Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280817AbRLJEff>; Sun, 9 Dec 2001 23:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281504AbRLJEf0>; Sun, 9 Dec 2001 23:35:26 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:6158 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S280817AbRLJEfP>; Sun, 9 Dec 2001 23:35:15 -0500
Subject: 2.5.1-pre8 -- Compile failure in ide-floppy.c
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0+cvs.2001.12.04.08.57 (Preview Release)
Date: 09 Dec 2001 20:37:29 -0800
Message-Id: <1007959053.29716.0.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



make[2]: Entering directory `/usr/src/linux/drivers/ide'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o ide-floppy.o ide-floppy.c
ide-floppy.c: In function `idefloppy_end_request':
ide-floppy.c:699: warning: comparison between pointer and integer
ide-floppy.c:699: warning: comparison between pointer and integer
ide-floppy.c: In function `idefloppy_queue_pc_head':
ide-floppy.c:779: incompatible types in assignment
ide-floppy.c: In function `idefloppy_create_rw_cmd':
ide-floppy.c:1214: warning: comparison between pointer and integer
ide-floppy.c: In function `idefloppy_do_request':
ide-floppy.c:1243: switch quantity not an integer
ide-floppy.c:1258: warning: unsigned int format, pointer arg (arg 2)
ide-floppy.c:1246: warning: unreachable code at beginning of switch statement
ide-floppy.c: In function `idefloppy_queue_pc_tail':
ide-floppy.c:1276: incompatible types in assignment
make[2]: *** [ide-floppy.o] Error 1

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m


