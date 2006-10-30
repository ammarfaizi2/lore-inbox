Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965506AbWJ3KqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965506AbWJ3KqB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965504AbWJ3KqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:46:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:61338 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965501AbWJ3Kpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:45:53 -0500
To: linux-arch@vger.kernel.org
Subject: [PATCH 3/7] severing uaccess.h -> sched.h
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Message-Id: <E1GeUeP-0002oP-8U@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 30 Oct 2006 10:45:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-x86_64/uaccess.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/asm-x86_64/uaccess.h b/include/asm-x86_64/uaccess.h
index 19f9917..d5dbc87 100644
--- a/include/asm-x86_64/uaccess.h
+++ b/include/asm-x86_64/uaccess.h
@@ -6,7 +6,6 @@ #define __X86_64_UACCESS_H
  */
 #include <linux/compiler.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/prefetch.h>
 #include <asm/page.h>
 
-- 
1.4.2.GIT


