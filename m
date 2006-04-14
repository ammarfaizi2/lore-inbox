Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWDNLmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWDNLmi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 07:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWDNLmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 07:42:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43015 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932185AbWDNLmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 07:42:37 -0400
Date: Fri, 14 Apr 2006 13:42:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/fat/misc.c: unexport fat_sync_bhs
Message-ID: <20060414114236.GK4162@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL_GPL(fat_sync_bhs).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm2-full/fs/fat/misc.c.old	2006-04-14 12:49:47.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/fs/fat/misc.c	2006-04-14 12:50:19.000000000 +0200
@@ -210,4 +210,3 @@
 	return err;
 }
 
-EXPORT_SYMBOL_GPL(fat_sync_bhs);

