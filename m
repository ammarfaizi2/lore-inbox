Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUGRS7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUGRS7K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 14:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUGRS7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 14:59:10 -0400
Received: from web53801.mail.yahoo.com ([206.190.36.196]:39300 "HELO
	web53801.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264389AbUGRS7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 14:59:09 -0400
Message-ID: <20040718185909.22648.qmail@web53801.mail.yahoo.com>
Date: Sun, 18 Jul 2004 11:59:09 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent functions from fs/autofs4 files
To: lkml <linux-kernel@vger.kernel.org>
Cc: raven@themaw.net, autofs@linux.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/fs/autofs4/autofs_i.h linux-2.6.7-new/fs/autofs4/autofs_i.h
--- linux-2.6.7-orig/fs/autofs4/autofs_i.h      2004-06-15 22:19:42.000000000 -0700
+++ linux-2.6.7-new/fs/autofs4/autofs_i.h       2004-07-18 08:49:11.000000000 -0700
@@ -138,7 +138,6 @@
 }

 struct inode *autofs4_get_inode(struct super_block *, struct autofs_info *);
-struct autofs_info *autofs4_init_inf(struct autofs_sb_info *, mode_t mode);
 void autofs4_free_ino(struct autofs_info *);

 /* Expiration */

