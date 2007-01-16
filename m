Return-Path: <linux-kernel-owner+w=401wt.eu-S1751429AbXAPJoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbXAPJoj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 04:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXAPJoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 04:44:39 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:44314 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbXAPJoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 04:44:38 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Subject: [PATCH] x86_64: Fix preprocessor condition
Date: Tue, 16 Jan 2007 04:44:29 -0500
Message-Id: <11689406692254-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.5.0.rc1.g696b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
---
 include/asm-x86_64/io.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-x86_64/io.h b/include/asm-x86_64/io.h
index 6ee9fad..7d0b568 100644
--- a/include/asm-x86_64/io.h
+++ b/include/asm-x86_64/io.h
@@ -100,7 +100,7 @@ __OUTS(l)
 
 #define IO_SPACE_LIMIT 0xffff
 
-#if defined(__KERNEL__) && __x86_64__
+#if defined(__KERNEL__) && defined(__x86_64__)
 
 #include <linux/vmalloc.h>
 
-- 
1.5.0.rc1.g696b

