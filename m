Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317535AbSGESmo>; Fri, 5 Jul 2002 14:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317537AbSGESmn>; Fri, 5 Jul 2002 14:42:43 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:10761 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317535AbSGESml>; Fri, 5 Jul 2002 14:42:41 -0400
Date: Fri, 5 Jul 2002 15:43:42 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] spelling fix for page-writeback.c
Message-ID: <Pine.LNX.4.44L.0207051542380.8346-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found this spelling fix in Craig Kulesa's minimal rmap patch.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".



diff -Nru a/mm/page-writeback.c b/mm/page-writeback.c
--- a/mm/page-writeback.c	Fri Jul  5 15:42:39 2002
+++ b/mm/page-writeback.c	Fri Jul  5 15:42:39 2002
@@ -336,7 +336,7 @@
  * If a page is already under I/O, generic_writepages() skips it, even
  * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
  * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
- * and msync() need to guarentee that all the data which was dirty at the time
+ * and msync() need to guarantee that all the data which was dirty at the time
  * the call was made get new I/O started against them.  The way to do this is
  * to run filemap_fdatawait() before calling filemap_fdatawrite().
  *

