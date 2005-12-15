Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422640AbVLOJSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbVLOJSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbVLOJSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:18:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:9898 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422638AbVLOJRf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:17:35 -0500
To: torvalds@osdl.org
Subject: [PATCH] auerswald.c: %zd for size_t
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpF0-0007yX-VC@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:17:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/usb/misc/auerswald.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

a76826ad561a25095f94f5ea37c0a740fb1a7372
diff --git a/drivers/usb/misc/auerswald.c b/drivers/usb/misc/auerswald.c
index 2a28cee..b293db3 100644
--- a/drivers/usb/misc/auerswald.c
+++ b/drivers/usb/misc/auerswald.c
@@ -1696,7 +1696,7 @@ static ssize_t auerchar_write (struct fi
 	int ret;
 	wait_queue_t wait;
 
-        dbg ("auerchar_write %d bytes", len);
+        dbg ("auerchar_write %zd bytes", len);
 
 	/* Error checking */
 	if (!ccp)
-- 
0.99.9.GIT

