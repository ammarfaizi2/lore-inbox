Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbTDGX1w (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTDGX1a (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:27:30 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12417
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263904AbTDGXSH (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:18:07 -0400
Date: Tue, 8 Apr 2003 01:37:02 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080037.h380b2tr009264@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove version crap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/sound/memalloc.h linux-2.5.67-ac1/include/sound/memalloc.h
--- linux-2.5.67/include/sound/memalloc.h	2003-03-26 20:00:00.000000000 +0000
+++ linux-2.5.67-ac1/include/sound/memalloc.h	2003-04-04 16:49:19.000000000 +0100
@@ -178,7 +178,7 @@
 /*
  * wrappers
  */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
+
 #ifdef CONFIG_PCI
 #if defined(__i386__) || defined(__ppc__) || defined(__x86_64__)
 #define HACK_PCI_ALLOC_CONSISTENT
@@ -187,7 +187,6 @@
 				    dma_addr_t *dma_handle);
 #endif /* arch */
 #endif /* CONFIG_PCI */
-#endif /* LINUX >= 2.4.0 */
 
 
 #endif /* __SOUND_MEMALLOC_H */
