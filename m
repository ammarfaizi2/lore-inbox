Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWCZVJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWCZVJo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWCZVJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:09:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5129 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751266AbWCZVJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:09:43 -0500
Date: Sun, 26 Mar 2006 23:09:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] typos: s/ducument/document/
Message-ID: <20060326210942.GU4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s/ducument/document/

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/DocBook/Makefile |    2 +-
 drivers/s390/char/sclp_rw.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16-mm1-full/Documentation/DocBook/Makefile.old	2006-03-26 20:08:55.000000000 +0200
+++ linux-2.6.16-mm1-full/Documentation/DocBook/Makefile	2006-03-26 20:09:04.000000000 +0200
@@ -2,7 +2,7 @@
 # This makefile is used to generate the kernel documentation,
 # primarily based on in-line comments in various source files.
 # See Documentation/kernel-doc-nano-HOWTO.txt for instruction in how
-# to ducument the SRC - and how to read it.
+# to document the SRC - and how to read it.
 # To add a new book the only step required is to add the book to the
 # list of DOCBOOKS.
 
--- linux-2.6.16-mm1-full/drivers/s390/char/sclp_rw.c.old	2006-03-26 20:09:13.000000000 +0200
+++ linux-2.6.16-mm1-full/drivers/s390/char/sclp_rw.c	2006-03-26 20:09:21.000000000 +0200
@@ -24,7 +24,7 @@
 
 /*
  * The room for the SCCB (only for writing) is not equal to a pages size
- * (as it is specified as the maximum size in the the SCLP ducumentation)
+ * (as it is specified as the maximum size in the the SCLP documentation)
  * because of the additional data structure described above.
  */
 #define MAX_SCCB_ROOM (PAGE_SIZE - sizeof(struct sclp_buffer))

