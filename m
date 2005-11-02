Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbVKBSRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbVKBSRw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbVKBSRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:17:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15634 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965169AbVKBSRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:17:51 -0500
Date: Wed, 2 Nov 2005 19:17:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/reiserfs/hashes.c should #include <linux/reiserfs_fs.h>
Message-ID: <20051102181749.GE4272@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the headers containing the prototypes for
it's global functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-full/fs/reiserfs/hashes.c.old	2005-11-02 18:26:16.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/reiserfs/hashes.c	2005-11-02 18:26:31.000000000 +0100
@@ -19,6 +19,7 @@
 //
 
 #include <linux/kernel.h>
+#include <linux/reiserfs_fs.h>
 #include <asm/types.h>
 #include <asm/bug.h>
 

