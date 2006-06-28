Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWF1Q5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWF1Q5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWF1Qz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:55:28 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44548 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751454AbWF1QzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:55:21 -0400
Date: Wed, 28 Jun 2006 18:55:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] typo fixes: specfic -> specific
Message-ID: <20060628165520.GE13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/mm/discontig.c                |    2 +-
 include/asm-arm/arch-at91rm9200/board.h |    2 +-
 sound/sparc/dbri.c                      |    2 +-
 usr/klibc/zlib/FAQ                      |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.17-mm3-full/arch/i386/mm/discontig.c.old	2006-06-27 20:36:43.000000000 +0200
+++ linux-2.6.17-mm3-full/arch/i386/mm/discontig.c	2006-06-27 20:37:07.000000000 +0200
@@ -43,7 +43,7 @@
 bootmem_data_t node0_bdata;
 
 /*
- * numa interface - we expect the numa architecture specfic code to have
+ * numa interface - we expect the numa architecture specific code to have
  *                  populated the following initialisation.
  *
  * 1) node_online_map  - the map of all nodes configured (online) in the system
--- linux-2.6.17-mm3-full/include/asm-arm/arch-at91rm9200/board.h.old	2006-06-27 20:37:17.000000000 +0200
+++ linux-2.6.17-mm3-full/include/asm-arm/arch-at91rm9200/board.h	2006-06-27 20:37:21.000000000 +0200
@@ -20,7 +20,7 @@
 
 /*
  * These are data structures found in platform_device.dev.platform_data,
- * and describing board-specfic data needed by drivers.  For example,
+ * and describing board-specific data needed by drivers.  For example,
  * which pin is used for a given GPIO role.
  *
  * In 2.6, drivers should strongly avoid board-specific knowledge so
--- linux-2.6.17-mm3-full/sound/sparc/dbri.c.old	2006-06-27 20:37:31.000000000 +0200
+++ linux-2.6.17-mm3-full/sound/sparc/dbri.c	2006-06-27 20:37:34.000000000 +0200
@@ -46,7 +46,7 @@
  *
  * I've tried to stick to the following function naming conventions:
  * snd_*	ALSA stuff
- * cs4215_*	CS4215 codec specfic stuff
+ * cs4215_*	CS4215 codec specific stuff
  * dbri_*	DBRI high-level stuff
  * other	DBRI low-level stuff
  */
--- linux-2.6.17-mm3-full/usr/klibc/zlib/FAQ.old	2006-06-27 20:37:41.000000000 +0200
+++ linux-2.6.17-mm3-full/usr/klibc/zlib/FAQ	2006-06-27 20:37:44.000000000 +0200
@@ -318,7 +318,7 @@
     correctly points to the zlib specification in RFC 1950 for the "deflate"
     transfer encoding, there have been reports of servers and browsers that
     incorrectly produce or expect raw deflate data per the deflate
-    specficiation in RFC 1951, most notably Microsoft. So even though the
+    specificiation in RFC 1951, most notably Microsoft. So even though the
     "deflate" transfer encoding using the zlib format would be the more
     efficient approach (and in fact exactly what the zlib format was designed
     for), using the "gzip" transfer encoding is probably more reliable due to

