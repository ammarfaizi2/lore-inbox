Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbWD0SDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbWD0SDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWD0SDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:03:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6406 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965173AbWD0SDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:03:33 -0400
Date: Thu, 27 Apr 2006 20:03:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/read_write.c: unexport iov_shorten
Message-ID: <20060427180331.GK3570@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL(iov_shorten).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 23 Apr 2006

--- linux-2.6.17-rc1-mm3-full/fs/read_write.c.old	2006-04-23 15:51:52.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/fs/read_write.c	2006-04-23 15:52:02.000000000 +0200
@@ -436,8 +436,6 @@
 	return seg;
 }
 
-EXPORT_SYMBOL(iov_shorten);
-
 /* A write operation does a read from user space and vice versa */
 #define vrfy_dir(type) ((type) == READ ? VERIFY_WRITE : VERIFY_READ)
 

