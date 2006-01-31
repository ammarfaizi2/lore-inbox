Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWAaDTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWAaDTZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWAaDTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:19:25 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:62601 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1030285AbWAaDTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:19:24 -0500
Message-ID: <43DED73B.7060902@tlinx.org>
Date: Mon, 30 Jan 2006 19:19:23 -0800
From: "L. A. Walsh" <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
CC: Linux-Xfs <linux-xfs@oss.sgi.com>
Subject: Compile warnings in XFS, kernel 2.6.15.1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are these warnings anything to worry about?

  CC      fs/xfs/xfs_bmap.o
  LD      fs/udf/udf.o
  LD      fs/udf/built-in.o
  CC      fs/dnotify.o
  CC      fs/xfs/xfs_bmap_btree.o
fs/xfs/xfs_bmap.c: In function `xfs_bmap_search_extents':
fs/xfs/xfs_bmap.c:3590: warning: long long unsigned int format, 
different type arg (arg 5)
  CC      fs/xfs/xfs_btree.o
  CC      fs/xfs/xfs_buf_item.o
  CC      fs/xfs/xfs_iget.o
  CC      fs/xfs/xfs_inode.o
  CC      fs/xfs/xfs_inode_item.o
  CC      fs/xfs/xfs_iocore.o
  CC      fs/xfs/xfs_iomap.o
  CC      fs/xfs/xfs_itable.o
fs/xfs/xfs_iomap.c: In function `xfs_iomap_write_direct':
fs/xfs/xfs_iomap.c:488: warning: long long unsigned int format, 
different type arg (arg 5)
fs/xfs/xfs_iomap.c: In function `xfs_iomap_write_delay':
fs/xfs/xfs_iomap.c:591: warning: long long unsigned int format, 
different type arg (arg 5)
fs/xfs/xfs_iomap.c:697: warning: long long unsigned int format, 
different type arg (arg 5)
fs/xfs/xfs_iomap.c: In function `xfs_iomap_write_allocate':
fs/xfs/xfs_iomap.c:834: warning: long long unsigned int format, 
different type arg (arg 5)
fs/xfs/xfs_iomap.c: In function `xfs_iomap_write_unwritten':
fs/xfs/xfs_iomap.c:941: warning: long long unsigned int format, 
different type arg (arg 5)
