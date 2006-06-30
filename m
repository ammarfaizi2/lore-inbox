Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWF3LdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWF3LdB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWF3LdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:33:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16392 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751624AbWF3Lc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:32:57 -0400
Date: Fri, 30 Jun 2006 13:32:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/read_write.c: EXPORT_UNUSED_SYMBOL
Message-ID: <20060630113256.GS19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks an unused export as EXPORT_UNUSED_SYMBOL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm4-full/fs/read_write.c.old	2006-06-30 02:58:56.000000000 +0200
+++ linux-2.6.17-mm4-full/fs/read_write.c	2006-06-30 02:59:15.000000000 +0200
@@ -436,7 +436,7 @@
 	return seg;
 }
 
-EXPORT_SYMBOL(iov_shorten);
+EXPORT_UNUSED_SYMBOL(iov_shorten);  /*  June 2006  */
 
 /* A write operation does a read from user space and vice versa */
 #define vrfy_dir(type) ((type) == READ ? VERIFY_WRITE : VERIFY_READ)

