Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbUEWQD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUEWQD0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 12:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUEWQD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 12:03:26 -0400
Received: from village.ehouse.ru ([193.111.92.18]:12554 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S263124AbUEWQDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 12:03:22 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] befs: typo fix
Date: Sun, 23 May 2004 00:12:03 +0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405230012.03190.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] befs: typo fix

Fix a typo in error message.

===== fs/befs/linuxvfs.c 1.20 vs edited =====
--- 1.20/fs/befs/linuxvfs.c	Sat May 15 06:00:21 2004
+++ edited/fs/befs/linuxvfs.c	Sat May 22 23:29:37 2004
@@ -584,7 +584,7 @@
 	return o;
 
       conv_err:
-	befs_error(sb, "Name using charecter set %s contains a charecter that "
+	befs_error(sb, "Name using character set %s contains a character that "
 		   "cannot be converted to unicode.", nls->charset);
 	befs_debug(sb, "<--- utf2nls()");
 	kfree(result);



