Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268396AbTCFVbB>; Thu, 6 Mar 2003 16:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268400AbTCFVbB>; Thu, 6 Mar 2003 16:31:01 -0500
Received: from [24.77.48.240] ([24.77.48.240]:41820 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268396AbTCFVbA>;
	Thu, 6 Mar 2003 16:31:00 -0500
Date: Thu, 6 Mar 2003 13:41:35 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200303062141.h26LfZK19533@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix breakage caused by spelling 'fix'
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a spelling "fix" that resulted in a compile error.

With apologies to Russell King.

diff -ur a/include/asm-arm/proc-fns.h b/include/asm-arm/proc-fns.h
--- a/include/asm-arm/proc-fns.h	Tue Mar  4 19:29:20 2003
+++ b/include/asm-arm/proc-fns.h	Thu Mar  6 11:46:15 2003
@@ -125,7 +125,7 @@
 
 #if 0
  * The following is to fool mkdep into generating the correct
- * dependencies.  Without this, it can't figure out that this
+ * dependencies.  Without this, it cant figure out that this
  * file does indeed depend on the cpu-*.h files.
 #include <asm/cpu-single.h>
 #include <asm/cpu-multi26.h>
