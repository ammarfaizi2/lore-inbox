Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWEAHNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWEAHNu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 03:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWEAHNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 03:13:44 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47377 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751305AbWEAHLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 03:11:46 -0400
Date: Mon, 1 May 2006 09:11:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/open.c: unexport sys_openat
Message-ID: <20060501071146.GN3570@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL_GPL(sys_openat).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 23 Apr 2006

--- linux-2.6.17-rc1-mm3-full/fs/open.c.old	2006-04-23 13:59:30.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/fs/open.c	2006-04-23 13:59:37.000000000 +0200
@@ -1108,7 +1108,6 @@
 
 	return do_sys_open(dfd, filename, flags, mode);
 }
-EXPORT_SYMBOL_GPL(sys_openat);
 
 #ifndef __alpha__
 

