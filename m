Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265020AbTGHAFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 20:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTGHAFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 20:05:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1271 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265020AbTGHAFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 20:05:05 -0400
Date: Tue, 8 Jul 2003 02:19:37 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: dwmw2@infradead.org
Cc: jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: JFFS2: many compile warnings with gcc 2.95 + kernel 2.5
Message-ID: <20030708001937.GA6848@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I observe the following warnings when compiling JFFS2 in 2.5.74-mm2 (but
this is not limited to -mm) with gcc 2.95:

<-- snip -->

...
  CC      fs/jffs2/read.o
fs/jffs2/read.c: In function `jffs2_read_dnode':
fs/jffs2/read.c:43: warning: unknown conversion type character `z' in format
fs/jffs2/read.c:43: warning: unknown conversion type character `z' in format
fs/jffs2/read.c:43: warning: too many arguments for format
  CC      fs/jffs2/nodemgmt.o
fs/jffs2/nodemgmt.c: In function `jffs2_mark_node_obsolete':
fs/jffs2/nodemgmt.c:533: warning: unknown conversion type character `z' in format
fs/jffs2/nodemgmt.c:533: warning: too many arguments for format
fs/jffs2/nodemgmt.c:552: warning: unknown conversion type character `z' in format
fs/jffs2/nodemgmt.c:552: warning: too many arguments for format
  CC      fs/jffs2/readinode.o
fs/jffs2/readinode.c: In function `jffs2_do_read_inode_internal':
fs/jffs2/readinode.c:516: warning: unknown conversion type character `z' in format
fs/jffs2/readinode.c:516: warning: unknown conversion type character `z' in format
fs/jffs2/readinode.c:516: warning: too many arguments for format
  CC      fs/jffs2/write.o
fs/jffs2/write.c: In function `jffs2_write_dnode':
fs/jffs2/write.c:112: warning: unknown conversion type character `z' in format
fs/jffs2/write.c:112: warning: too many arguments for format
fs/jffs2/write.c:140: warning: unknown conversion type character `z' in format
fs/jffs2/write.c:140: warning: unknown conversion type character `z' in format
fs/jffs2/write.c:140: warning: too many arguments for format
fs/jffs2/write.c: In function `jffs2_write_dirent':
fs/jffs2/write.c:245: warning: unknown conversion type character `z' in format
fs/jffs2/write.c:245: warning: unknown conversion type character `z' in format
fs/jffs2/write.c:245: warning: too many arguments for format
  CC      fs/jffs2/scan.o
  CC      fs/jffs2/gc.o
fs/jffs2/gc.c: In function `jffs2_garbage_collect_pristine':
fs/jffs2/gc.c:585: warning: unknown conversion type character `z' in format
fs/jffs2/gc.c:585: warning: too many arguments for format
fs/jffs2/gc.c: In function `jffs2_garbage_collect_metadata':
fs/jffs2/gc.c:661: warning: unknown conversion type character `z' in format
fs/jffs2/gc.c:661: warning: too many arguments for format
fs/jffs2/gc.c: In function `jffs2_garbage_collect_dirent':
fs/jffs2/gc.c:728: warning: unknown conversion type character `z' in format
fs/jffs2/gc.c:728: warning: too many arguments for format
fs/jffs2/gc.c: In function `jffs2_garbage_collect_deletion_dirent':
fs/jffs2/gc.c:786: warning: unknown conversion type character `z' in format
fs/jffs2/gc.c:786: warning: unknown conversion type character `z' in format
fs/jffs2/gc.c:786: warning: too many arguments for format
fs/jffs2/gc.c:803: warning: unknown conversion type character `z' in format
fs/jffs2/gc.c:803: warning: unknown conversion type character `z' in format
fs/jffs2/gc.c:803: warning: too many arguments for format
fs/jffs2/gc.c:831: warning: unknown conversion type character `z' in format
fs/jffs2/gc.c:831: warning: too many arguments for format
fs/jffs2/gc.c: In function `jffs2_garbage_collect_hole':
fs/jffs2/gc.c:893: warning: unknown conversion type character `z' in format
fs/jffs2/gc.c:893: warning: too many arguments for format
fs/jffs2/gc.c:905: warning: unknown conversion type character `z' in format
fs/jffs2/gc.c:905: warning: too many arguments for format
fs/jffs2/gc.c:951: warning: unknown conversion type character `z' in format
fs/jffs2/gc.c:951: warning: too many arguments for format
fs/jffs2/gc.c: In function `jffs2_garbage_collect_dnode':
fs/jffs2/gc.c:1080: warning: unknown conversion type character `z' in format
fs/jffs2/gc.c:1080: warning: too many arguments for format
  CC      fs/jffs2/symlink.o
  CC      fs/jffs2/build.o
  CC      fs/jffs2/erase.o
fs/jffs2/erase.c: In function `jffs2_mark_erased_block':
fs/jffs2/erase.c:320: warning: unknown conversion type character `z' in format
fs/jffs2/erase.c:320: warning: too many arguments for format
fs/jffs2/erase.c:382: warning: unknown conversion type character `z' in format
fs/jffs2/erase.c:382: warning: too many arguments for format
  CC      fs/jffs2/background.o
  CC      fs/jffs2/fs.o
  CC      fs/jffs2/writev.o
  CC      fs/jffs2/wbuf.o
fs/jffs2/wbuf.c: In function `jffs2_flush_wbuf':
fs/jffs2/wbuf.c:189: warning: unknown conversion type character `z' in format
fs/jffs2/wbuf.c:189: warning: too many arguments for format
fs/jffs2/wbuf.c: In function `jffs2_flash_read':
fs/jffs2/wbuf.c:476: warning: unknown conversion type character `z' in format
fs/jffs2/wbuf.c:476: warning: long long unsigned int format, different type arg (arg 2)
fs/jffs2/wbuf.c:476: warning: too many arguments for format
...

<--  snip   -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

