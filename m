Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSGHG4P>; Mon, 8 Jul 2002 02:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316577AbSGHG4P>; Mon, 8 Jul 2002 02:56:15 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:21509 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S316390AbSGHG4O>; Mon, 8 Jul 2002 02:56:14 -0400
Message-ID: <3D2936DD.5040700@megapathdsl.net>
Date: Sun, 07 Jul 2002 23:53:17 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020702
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.25 -- Build error -- fs/ntfs/layout.h:299: unnamed fields of
 type other than struct or union are not allowed
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,./.aops.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix include -DMODULE -DNTFS_VERSION=\"2.0.14\" -DDEBUG  -DKBUILD_BASENAME=aops   -c -o aops.o aops.c
In file included from inode.h:29,
                 from debug.h:30,
                 from ntfs.h:40,
                 from aops.c:30:
layout.h:299: unnamed fields of type other than struct or union are not allowed
layout.h:1449: unnamed fields of type other than struct or union are not allowed
layout.h:1465: unnamed fields of type other than struct or union are not allowed
layout.h:1714: unnamed fields of type other than struct or union are not allowed
layout.h:1891: unnamed fields of type other than struct or union are not allowed
layout.h:2051: unnamed fields of type other than struct or union are not allowed
layout.h:2063: unnamed fields of type other than struct or union are not allowed
make[2]: *** [aops.o] Error 1
make[2]: Leaving directory `/usr/src/linux/fs/ntfs'

CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_EXT3_FS=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y


