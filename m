Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTJAQZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbTJAQVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:21:33 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:56981 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262400AbTJAQTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:19:18 -0400
Subject: [PATCH] [TRIVIAL 3/12] 2.6.0-test6-bk remove reference to
	modules.txt in sound/oss/dmasound/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1065025094.1995.2394.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Oct 2003 10:18:14 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the reference to Documentation/modules.txt,
which has been removed.  The patch was made against the current
2.6-bk tree.

Steven

--- 2.6-bk-current/sound/oss/dmasound/Kconfig	2003-09-30 21:07:56.000000000 -0600
+++ linux/sound/oss/dmasound/Kconfig	2003-09-30 21:52:31.000000000 -0600
@@ -7,10 +7,8 @@
 	  Y to this question. This will provide a Sun-like /dev/audio,
 	  compatible with the Linux/i386 sound system. Otherwise, say N.
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you
-	  want). If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
+	  To compile this driver as a module, choose M here: the
+	  module will be called dmasound_atari.
 
 config DMASOUND_PMAC
 	tristate "PowerMac DMA sound support"
@@ -21,10 +19,8 @@
 	  answer Y to this question. This will provide a Sun-like /dev/audio,
 	  compatible with the Linux/i386 sound system. Otherwise, say N.
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you
-	  want). If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
+	  To compile this driver as a module, choose M here: the
+	  module will be called dmasound_pmac.
 
 config DMASOUND_PAULA
 	tristate "Amiga DMA sound support"
@@ -35,10 +31,8 @@
 	  Y to this question. This will provide a Sun-like /dev/audio,
 	  compatible with the Linux/i386 sound system. Otherwise, say N.
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you
-	  want). If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
+	  To compile this driver as a module, choose M here: the
+	  module will be called dmasound_paula.
 
 config DMASOUND_Q40
 	tristate "Q40 sound support"
@@ -49,10 +43,8 @@
 	  Y to this question. This will provide a Sun-like /dev/audio,
 	  compatible with the Linux/i386 sound system. Otherwise, say N.
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you
-	  want). If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
+	  To compile this driver as a module, choose M here: the
+	  module will be called dmasound_q40.
 
 config DMASOUND
 	tristate







