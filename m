Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263756AbTCUSiM>; Fri, 21 Mar 2003 13:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263744AbTCUShW>; Fri, 21 Mar 2003 13:37:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4228
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263741AbTCUSfL>; Fri, 21 Mar 2003 13:35:11 -0500
Date: Fri, 21 Mar 2003 19:50:26 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211950.h2LJoQOZ026049@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: __NO_VERSION__ for autofs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/autofs/inode.c linux-2.5.65-ac2/fs/autofs/inode.c
--- linux-2.5.65/fs/autofs/inode.c	2003-02-10 18:38:48.000000000 +0000
+++ linux-2.5.65-ac2/fs/autofs/inode.c	2003-03-14 00:52:26.000000000 +0000
@@ -16,7 +16,6 @@
 #include <linux/file.h>
 #include <asm/bitops.h>
 #include "autofs_i.h"
-#define __NO_VERSION__
 #include <linux/module.h>
 
 static void autofs_put_super(struct super_block *sb)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/autofs4/inode.c linux-2.5.65-ac2/fs/autofs4/inode.c
--- linux-2.5.65/fs/autofs4/inode.c	2003-02-10 18:38:48.000000000 +0000
+++ linux-2.5.65-ac2/fs/autofs4/inode.c	2003-03-14 00:52:26.000000000 +0000
@@ -16,7 +16,6 @@
 #include <linux/pagemap.h>
 #include <asm/bitops.h>
 #include "autofs_i.h"
-#define __NO_VERSION__
 #include <linux/module.h>
 
 static void ino_lnkfree(struct autofs_info *ino)
