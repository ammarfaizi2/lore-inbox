Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWDWMQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWDWMQV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 08:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWDWMQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 08:16:21 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17676 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751391AbWDWMQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 08:16:21 -0400
Date: Sun, 23 Apr 2006 14:16:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/open.c: unexport sys_openat
Message-ID: <20060423121620.GP5010@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL_GPL(sys_openat).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm3-full/fs/open.c.old	2006-04-23 13:59:30.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/fs/open.c	2006-04-23 13:59:37.000000000 +0200
@@ -1108,7 +1108,6 @@
 
 	return do_sys_open(dfd, filename, flags, mode);
 }
-EXPORT_SYMBOL_GPL(sys_openat);
 
 #ifndef __alpha__
 

