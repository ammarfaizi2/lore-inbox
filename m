Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTJAQgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTJAQdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:33:55 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:13719 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262444AbTJAQVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:21:17 -0400
Subject: [PATCH] [TRIVIAL 11/12] 2.6.0-test6-bk remove reference to
	modules.txt in sound/oss/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1065025212.1995.2423.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Oct 2003 10:20:12 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the reference to Documentation/modules.txt,
which has been removed.  The patch was made against the current
2.6-bk tree.

Steven

--- 2.6-bk-current/sound/oss/Kconfig	2003-09-30 21:11:08.000000000 -0600
+++ linux/sound/oss/Kconfig	2003-09-30 22:26:12.000000000 -0600
@@ -17,10 +17,8 @@
 	  don't need this driver as most TV cards handle sound with a short
 	  cable from the TV card to your sound card's line-in.
 
-	  This driver is available as a module called btaudio ( = code
-	  which can be inserted in and removed from the running kernel
-	  whenever you want). If you want to compile it as a module, say M
-	  here and read <file:Documentation/modules.txt>.
+	  To compile this driver as a module, choose M here: the
+	  module will be called btaudio.
 
 config SOUND_CMPCI
 	tristate "C-Media PCI (CMI8338/8738)"







