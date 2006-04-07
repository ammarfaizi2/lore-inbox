Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWDGVRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWDGVRk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWDGVRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:17:39 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7184 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964961AbWDGVRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:17:39 -0400
Date: Fri, 7 Apr 2006 23:17:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kkeil@suse.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/capi/capiutil.c: unexport capi_message2str
Message-ID: <20060407211736.GO7118@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an unused EXPORT_SYMBOL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm1-full/drivers/isdn/capi/capiutil.c.old	2006-04-07 10:47:30.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/isdn/capi/capiutil.c	2006-04-07 10:47:37.000000000 +0200
@@ -855,5 +855,4 @@
 EXPORT_SYMBOL(capi_cmsg_header);
 EXPORT_SYMBOL(capi_cmd2str);
 EXPORT_SYMBOL(capi_cmsg2str);
-EXPORT_SYMBOL(capi_message2str);
 EXPORT_SYMBOL(capi_info2str);

