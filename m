Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263780AbTEODTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbTEODSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:47 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:12268 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263783AbTEODSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:20 -0400
Date: Thu, 15 May 2003 04:31:07 +0100
Message-Id: <200305150331.h4F3V74K000627@deviant.impure.org.uk>
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Age old cs89x0 register define 'fixes' ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remember these? There never was an outcome as to whether or
not their doing the right thing.  Any complaints from this being
in 2.4 for nearly a year ?

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/cs89x0.h linux-2.5/drivers/net/cs89x0.h
--- bk-linus/drivers/net/cs89x0.h	2003-04-10 06:01:20.000000000 +0100
+++ linux-2.5/drivers/net/cs89x0.h	2003-03-17 23:42:26.000000000 +0000
@@ -385,11 +385,11 @@
 #define A_CNF_10B_T 0x0001
 #define A_CNF_AUI 0x0002
 #define A_CNF_10B_2 0x0004
-#define A_CNF_MEDIA_TYPE 0x0060
-#define A_CNF_MEDIA_AUTO 0x0000
+#define A_CNF_MEDIA_TYPE 0x0070
+#define A_CNF_MEDIA_AUTO 0x0070
 #define A_CNF_MEDIA_10B_T 0x0020
 #define A_CNF_MEDIA_AUI 0x0040
-#define A_CNF_MEDIA_10B_2 0x0060
+#define A_CNF_MEDIA_10B_2 0x0010
 #define A_CNF_DC_DC_POLARITY 0x0080
 #define A_CNF_NO_AUTO_POLARITY 0x2000
 #define A_CNF_LOW_RX_SQUELCH 0x4000
