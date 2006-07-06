Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWGFRtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWGFRtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWGFRtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:49:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:33681 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030366AbWGFRtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:49:07 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: Novell / SUSE Labs
To: Andrew Morton <akpm@osdl.org>
Subject: [TRIVIAL PATCH] Remove leftover ext3 acl declarations
Date: Thu, 6 Jul 2006 19:46:50 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607061946.50708.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These functions no longer exist; remove their declarations.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.17/fs/ext3/acl.h
===================================================================
--- linux-2.6.17.orig/fs/ext3/acl.h
+++ linux-2.6.17/fs/ext3/acl.h
@@ -62,9 +62,6 @@ extern int ext3_permission (struct inode
 extern int ext3_acl_chmod (struct inode *);
 extern int ext3_init_acl (handle_t *, struct inode *, struct inode *);
 
-extern int init_ext3_acl(void);
-extern void exit_ext3_acl(void);
-
 #else  /* CONFIG_EXT3_FS_POSIX_ACL */
 #include <linux/sched.h>
 #define ext3_permission NULL

-- 
Andreas Gruenbacher <agruen@suse.de>
Novell / SUSE Labs
