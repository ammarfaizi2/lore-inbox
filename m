Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbTDGXgp (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTDGXel (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:34:41 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15745
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263746AbTDGXTt (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:19:49 -0400
Date: Tue, 8 Apr 2003 01:38:45 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080038.h380cjDN009282@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove version.h's
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/core/memory_wrapper.c linux-2.5.67-ac1/sound/core/memory_wrapper.c
--- linux-2.5.67/sound/core/memory_wrapper.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/core/memory_wrapper.c	2003-04-03 23:52:57.000000000 +0100
@@ -19,7 +19,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/pci.h>
 #include <sound/memalloc.h>
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/core/sgbuf.c linux-2.5.67-ac1/sound/core/sgbuf.c
--- linux-2.5.67/sound/core/sgbuf.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/core/sgbuf.c	2003-04-03 23:52:57.000000000 +0100
@@ -20,7 +20,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/core/wrappers.c linux-2.5.67-ac1/sound/core/wrappers.c
--- linux-2.5.67/sound/core/wrappers.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/core/wrappers.c	2003-04-03 23:52:57.000000000 +0100
@@ -19,7 +19,6 @@
  *
  */
 
-#include <linux/version.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/slab.h>
