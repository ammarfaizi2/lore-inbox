Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283477AbRK3Ct3>; Thu, 29 Nov 2001 21:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283481AbRK3CtT>; Thu, 29 Nov 2001 21:49:19 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:8718 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S283477AbRK3CtK>; Thu, 29 Nov 2001 21:49:10 -0500
Message-ID: <3C06F3A5.D407607A@delusion.de>
Date: Fri, 30 Nov 2001 03:49:09 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Stuff that needs fixing in 2.5.1-pre4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Below a few things that should probably be fixed in the current 2.5. tree.

Regards,
Udo.


drivers/ide/
pdc202xx.c: In function `config_chipset_for_dma':
pdc202xx.c:530: warning: `drive_pci' might be used uninitialized in this function

fs/fat/
inode.c: In function `fat_writepage':
inode.c:859: warning: passing arg 2 of `block_write_full_page' from incompatible pointer type
inode.c: In function `fat_readpage':
inode.c:863: warning: passing arg 2 of `block_read_full_page' from incompatible pointer type
inode.c: In function `fat_prepare_write':
inode.c:868: warning: passing arg 4 of `cont_prepare_write' from incompatible pointer type
inode.c: In function `_fat_bmap':
inode.c:872: warning: passing arg 3 of `generic_block_bmap' from incompatible pointer type

/fs/minix/
In file included from itree_v1.c:47:
itree_common.c: In function `truncate':
itree_common.c:305: warning: passing arg 3 of `block_truncate_page' from incompatible pointer type
