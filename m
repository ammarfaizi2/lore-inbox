Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263742AbTCUSiL>; Fri, 21 Mar 2003 13:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263736AbTCUSh1>; Fri, 21 Mar 2003 13:37:27 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5764
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263742AbTCUSfq>; Fri, 21 Mar 2003 13:35:46 -0500
Date: Fri, 21 Mar 2003 19:51:01 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211951.h2LJp1Sa026061@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove __NO_VERSION__ in cifs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/cifs/cifs_debug.c linux-2.5.65-ac2/fs/cifs/cifs_debug.c
--- linux-2.5.65/fs/cifs/cifs_debug.c	2003-03-18 16:46:51.000000000 +0000
+++ linux-2.5.65-ac2/fs/cifs/cifs_debug.c	2003-03-18 17:07:42.000000000 +0000
@@ -22,7 +22,6 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <asm/uaccess.h>
