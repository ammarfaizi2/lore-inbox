Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261273AbSKBTTn>; Sat, 2 Nov 2002 14:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSKBTTn>; Sat, 2 Nov 2002 14:19:43 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:58599 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261273AbSKBTTl>; Sat, 2 Nov 2002 14:19:41 -0500
Date: Sat, 2 Nov 2002 20:26:06 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org, <trivial@rustcorp.com.au>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: [UPATCH,TRIVIAL] generic_fillattr() duplicate line. (fwd)
Message-ID: <Pine.NEB.4.44.0211022018430.8262-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

while looking through some old linux-kernel mails I found the mail below.
The duplicate line was introduced by your
  [PATCH] (1/5) beginning of getattr series.
patch and is still present in 2.5.45.

cu
Adrian


---------- Forwarded message ----------
Date: Sat, 27 Jul 2002 06:48:11 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: linux-kernel@vger.kernel.org
Subject: [UPATCH,TRIVIAL] generic_fillattr() duplicate line.

Hello.

--- linux-2.5.28/fs/stat.c~	Sat Jul  6 18:33:10 2002
+++ linux-2.5.28/fs/stat.c	Sat Jul 27 06:23:17 2002
@@ -27,7 +27,6 @@
 	stat->atime = inode->i_atime;
 	stat->mtime = inode->i_mtime;
 	stat->ctime = inode->i_ctime;
-	stat->ctime = inode->i_ctime;
 	stat->size = inode->i_size;
 	stat->blocks = inode->i_blocks;
 	stat->blksize = inode->i_blksize;

Oleg.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/





