Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbWJPLZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWJPLZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 07:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWJPLZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 07:25:27 -0400
Received: from fc-cn.com ([218.25.172.144]:32016 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751521AbWJPLZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 07:25:26 -0400
Date: Mon, 16 Oct 2006 19:42:23 +0800
From: Qi Yong <qiyong@fc-cn.com>
To: bunk@stusta.de
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [patch] jffs2_follow_link() typo fix
Message-ID: <20061016114223.GA23424@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

typo fix: noticed this typo while reading the patch
"jffs2: fix symlink error handling"

	qiyong

diff --git a/fs/jffs2/symlink.c b/fs/jffs2/symlink.c
index fc211b6..b90d5aa 100644
--- a/fs/jffs2/symlink.c
+++ b/fs/jffs2/symlink.c
@@ -51,7 +51,7 @@ static void *jffs2_follow_link(struct de
 	 */
 
 	if (!p) {
-		printk(KERN_ERR "jffs2_follow_link(): can't find symlink taerget\n");
+		printk(KERN_ERR "jffs2_follow_link(): can't find symlink target\n");
 		p = ERR_PTR(-EIO);
 	}
 	D1(printk(KERN_DEBUG "jffs2_follow_link(): target path is '%s'\n", (char *) f->target));
