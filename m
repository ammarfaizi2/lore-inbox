Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVBJPqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVBJPqB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVBJPqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:46:00 -0500
Received: from sd291.sivit.org ([194.146.225.122]:40420 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262146AbVBJPoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:44:01 -0500
Date: Thu, 10 Feb 2005 16:45:42 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/5] sonypi: add another HELP button event
Message-ID: <20050210154542.GG3493@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

Add another HELP button event.
Increment the version number.

Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 sonypi.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

===================================================================

Index: drivers/char/sonypi.h
===================================================================
--- a/drivers/char/sonypi.h	(revision 26539)
+++ b/drivers/char/sonypi.h	(revision 26540)
@@ -1,7 +1,7 @@
 /*
  * Sony Programmable I/O Control Device driver for VAIO
  *
- * Copyright (C) 2001-2004 Stelian Pop <stelian@popies.net>
+ * Copyright (C) 2001-2005 Stelian Pop <stelian@popies.net>
  *
  * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
@@ -36,7 +36,7 @@
 
 #ifdef __KERNEL__
 
-#define SONYPI_DRIVER_VERSION	 "1.25"
+#define SONYPI_DRIVER_VERSION	 "1.26"
 
 #define SONYPI_DEVICE_MODEL_TYPE1	1
 #define SONYPI_DEVICE_MODEL_TYPE2	2
@@ -330,6 +330,7 @@ struct sonypi_eventtypes {
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_PKEY_MASK, sonypi_pkeyev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x11, SONYPI_BACK_MASK, sonypi_backev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_HELP_MASK, sonypi_helpev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_HELP_MASK, sonypi_helpev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_ZOOM_MASK, sonypi_zoomev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x20, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
-- 
Stelian Pop <stelian@popies.net>
