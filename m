Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVHBJwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVHBJwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 05:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVHBJwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 05:52:17 -0400
Received: from gw.alcove.fr ([81.80.245.157]:46269 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261447AbVHBJwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 05:52:12 -0400
Subject: [PATCH] sonypi: remove obsolete event
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 11:50:41 +0200
Message-Id: <1122976241.4659.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had this one in my tree for a long time, please apply.

Stelian.

Remove old obsolete event.

Signed-off-by: Stelian Pop <stelian@popies.net>

Index: linux-2.6.git/drivers/char/sonypi.c
===================================================================
--- linux-2.6.git.orig/drivers/char/sonypi.c	2005-08-02 10:22:15.000000000 +0200
+++ linux-2.6.git/drivers/char/sonypi.c	2005-08-02 10:22:18.000000000 +0200
@@ -406,7 +406,6 @@
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_PKEY_MASK, sonypi_pkeyev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x11, SONYPI_BACK_MASK, sonypi_backev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_HELP_MASK, sonypi_helpev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_HELP_MASK, sonypi_helpev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_ZOOM_MASK, sonypi_zoomev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x20, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },

-- 
Stelian Pop <stelian@popies.net>

