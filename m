Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVHWVrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVHWVrV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVHWVoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:44:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15030 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932432AbVHWVoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:44:34 -0400
To: torvalds@osdl.org
Subject: [PATCH] (34/43) vidc gcc4 fix
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gcL-0007ED-9g@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:47:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

removes an extern for a static variable.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-s390/sound/oss/vidc.h RC13-rc6-git13-vidc/sound/oss/vidc.h
--- RC13-rc6-git13-s390/sound/oss/vidc.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-vidc/sound/oss/vidc.h	2005-08-21 13:17:15.000000000 -0400
@@ -10,10 +10,6 @@
  *  VIDC sound function prototypes
  */
 
-/* vidc.c */
-
-extern int vidc_busy;
-
 /* vidc_fill.S */
 
 /*
