Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268670AbUIQKpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268670AbUIQKpo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268681AbUIQKpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:45:43 -0400
Received: from sd291.sivit.org ([194.146.225.122]:15578 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268670AbUIQKlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:41:46 -0400
Date: Fri, 17 Sep 2004 12:42:27 +0200
From: Stelian Pop <stelian@popies.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add sonypi specific events to the input layer
Message-ID: <20040917104226.GB3089@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch adds some sonypi specific events to the input
layer. 

When possible (for KEY_BACK, KEY_HELP, KEY_ZOOM, KEY_CAMERA for example)
I used the existing events, but some events just have no mapping.

Once this patch is accepted (if it is :) ), I will follow with a patch
for sonypi adding full input support for (almost) all the Vaio events.

Thanks,

Stelian.

Signed-off-by: Stelian Pop <stelian@popies.net>

===== linux-2.6/include/linux/input.h 1.50 vs edited =====
--- 1.50/include/linux/input.h	2004-06-06 11:08:11 +02:00
+++ edited/linux-2.6/include/linux/input.h	2004-09-17 10:26:15 +02:00
@@ -473,6 +473,28 @@
 #define KEY_INS_LINE		0x1c2
 #define KEY_DEL_LINE		0x1c3
 
+#define KEY_FN			0x1d0
+#define KEY_FN_ESC		0x1d1
+#define KEY_FN_F1		0x1d2
+#define KEY_FN_F2		0x1d3
+#define KEY_FN_F3		0x1d4
+#define KEY_FN_F4		0x1d5
+#define KEY_FN_F5		0x1d6
+#define KEY_FN_F6		0x1d7
+#define KEY_FN_F7		0x1d8
+#define KEY_FN_F8		0x1d9
+#define KEY_FN_F9		0x1da
+#define KEY_FN_F10		0x1db
+#define KEY_FN_F11		0x1dc
+#define KEY_FN_F12		0x1dd
+#define KEY_FN_1		0x1de
+#define KEY_FN_2		0x1df
+#define KEY_FN_D		0x1e0
+#define KEY_FN_E		0x1e1
+#define KEY_FN_F		0x1e2
+#define KEY_FN_S		0x1e3
+#define KEY_FN_B		0x1e4
+
 #define KEY_MAX			0x1ff
 
 /*
-- 
Stelian Pop <stelian@popies.net>    
