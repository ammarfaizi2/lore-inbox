Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263754AbTCUSkq>; Fri, 21 Mar 2003 13:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbTCUSjc>; Fri, 21 Mar 2003 13:39:32 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11908
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263757AbTCUSjB>; Fri, 21 Mar 2003 13:39:01 -0500
Date: Fri, 21 Mar 2003 19:54:17 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211954.h2LJsHmx026109@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove __NO_VERSION__ from procfs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/proc/inode.c linux-2.5.65-ac2/fs/proc/inode.c
--- linux-2.5.65/fs/proc/inode.c	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.65-ac2/fs/proc/inode.c	2003-03-14 00:52:26.000000000 +0000
@@ -13,7 +13,6 @@
 #include <linux/file.h>
 #include <linux/limits.h>
 #include <linux/init.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
