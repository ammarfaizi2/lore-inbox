Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965390AbWI0GiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965390AbWI0GiS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965391AbWI0GiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:38:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:14037 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965390AbWI0GiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:38:17 -0400
Date: Wed, 27 Sep 2006 07:38:14 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sys_getcpu() prototype annotated
Message-ID: <20060927063814.GQ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/syscalls.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index acbc68c..815a7c9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -597,6 +597,6 @@ asmlinkage long sys_get_robust_list(int 
 				    size_t __user *len_ptr);
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
-asmlinkage long sys_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *cache);
+asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct getcpu_cache __user *cache);
 
 #endif
-- 
1.4.2.GIT

