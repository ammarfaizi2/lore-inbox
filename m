Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936374AbWLDMhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936374AbWLDMhF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936351AbWLDMhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:37:04 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:25311 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936375AbWLDMg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:36:57 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Adrian Bunk <bunk@stusta.de>
Subject: [PATCH 09/35] fs/stack.c should #include <linux/fs_stack.h>
Date: Mon,  4 Dec 2006 07:30:42 -0500
Message-Id: <11652354694161-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

Every file should #include the headers containing the prototypes for
its global functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---
 fs/stack.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fs/stack.c b/fs/stack.c
index 03987f2..8ffb880 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -1,5 +1,6 @@
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_stack.h>
 
 /* does _NOT_ require i_mutex to be held.
  *
-- 
1.4.3.3

