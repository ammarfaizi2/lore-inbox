Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWIWRVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWIWRVh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 13:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWIWRVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 13:21:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:24712 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751333AbWIWRVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 13:21:36 -0400
Date: Sat, 23 Sep 2006 18:21:35 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more get_property() fallout
Message-ID: <20060923172135.GL29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/video/riva/fbdev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 61a4665..4acde4f 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -1826,7 +1826,7 @@ static int __devinit riva_get_EDID_OF(st
 {
 	struct riva_par *par = info->par;
 	struct device_node *dp;
-	unsigned char *pedid = NULL;
+	const unsigned char *pedid = NULL;
 	const unsigned char *disptype = NULL;
 	static char *propnames[] = {
 		"DFP,EDID", "LCD,EDID", "EDID", "EDID1", "EDID,B", "EDID,A", NULL };
-- 
1.4.2.GIT

