Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318683AbSG0Cls>; Fri, 26 Jul 2002 22:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318684AbSG0Cls>; Fri, 26 Jul 2002 22:41:48 -0400
Received: from www.sgg.ru ([217.23.135.2]:48388 "EHLO mail.sgg.ru")
	by vger.kernel.org with ESMTP id <S318683AbSG0Clr>;
	Fri, 26 Jul 2002 22:41:47 -0400
Message-ID: <3D4209EB.22F7DE5A@tv-sign.ru>
Date: Sat, 27 Jul 2002 06:48:11 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [UPATCH,TRIVIAL] generic_fillattr() duplicate line.
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
