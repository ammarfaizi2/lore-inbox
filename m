Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314106AbSEFF4Y>; Mon, 6 May 2002 01:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314123AbSEFF4X>; Mon, 6 May 2002 01:56:23 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:15110 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S314106AbSEFF4W>; Mon, 6 May 2002 01:56:22 -0400
Message-ID: <3CD61A42.7050502@megapathdsl.net>
Date: Sun, 05 May 2002 22:53:06 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020504
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.14 -- fs/fs.o: In function `end_buffer_read_file_async': undefined
 reference to `clear_buffer_async'
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/fs.o: In function `end_buffer_read_file_async':
fs/fs.o(.text+0x705a4): undefined reference to `clear_buffer_async'
fs/fs.o(.text+0x705c9): undefined reference to `buffer_async'
fs/fs.o: In function `ntfs_file_read_block':
fs/fs.o(.text+0x70a5c): undefined reference to `set_buffer_async'
fs/fs.o: In function `end_buffer_read_mftbmp_async':
fs/fs.o(.text+0x70e34): undefined reference to `clear_buffer_async'
fs/fs.o(.text+0x70e59): undefined reference to `buffer_async'
fs/fs.o: In function `ntfs_mftbmp_readpage':
fs/fs.o(.text+0x7125c): undefined reference to `set_buffer_async'
fs/fs.o: In function `end_buffer_read_mst_async':
fs/fs.o(.text+0x71411): undefined reference to `clear_buffer_async'
fs/fs.o(.text+0x71439): undefined reference to `buffer_async'
fs/fs.o: In function `ntfs_mst_readpage':
fs/fs.o(.text+0x719fc): undefined reference to `set_buffer_async'
make: *** [vmlinux] Error 1

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_MK7=y

#
# File systems
#
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

