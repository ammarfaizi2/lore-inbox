Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315560AbSECFyu>; Fri, 3 May 2002 01:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315561AbSECFyt>; Fri, 3 May 2002 01:54:49 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:35342 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315560AbSECFyp>; Fri, 3 May 2002 01:54:45 -0400
Message-ID: <3CD22590.5010906@megapathdsl.net>
Date: Thu, 02 May 2002 22:52:16 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020426
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.13 -- UFS compile error in fs/ufs/super.c:661: In function `ufs_fill_super':
 parse error before "uspi"
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon 
-DKBUILD_BASENAME=super  -c -o super.o super.c
super.c: In function `ufs_fill_super':
super.c:661: parse error before "uspi"
super.c:666: parse error before "uspi"
super.c:676: parse error before "uspi"
super.c:681: parse error before "uspi"
make[3]: *** [super.o] Error 1
make[3]: Leaving directory `/usr/src/linux/fs/ufs'

CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_HFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_JFS_FS=y
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=y
CONFIG_UFS_FS=y

