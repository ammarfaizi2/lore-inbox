Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269670AbTGULWz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 07:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269685AbTGULWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 07:22:55 -0400
Received: from dp.samba.org ([66.70.73.150]:16365 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269670AbTGULWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 07:22:54 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] [resend patch] CONFIG_X86_GENERIC description fixup
Date: Mon, 21 Jul 2003 21:24:25 +1000
Message-Id: <20030721113756.7D6352C717@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I like the clearer explanation --RR ]

From:  Stewart Smith <stewart@linux.org.au>

  as per thread on lkml a little while ago, a better explanation
  of the X86_GENERIC config option follows. The person who questioned
  it originally seemed to like this improved version, so that's one point :)
  
  

--- trivial-2.5.75-bk3/arch/i386/Kconfig.orig	2003-07-21 21:23:02.000000000 +1000
+++ trivial-2.5.75-bk3/arch/i386/Kconfig	2003-07-21 21:23:02.000000000 +1000
@@ -303,9 +303,13 @@
 config X86_GENERIC
        bool "Generic x86 support" 
        help
-       	  Including some tuning for non selected x86 CPUs too.
-	  when it has moderate overhead. This is intended for generic 
-	  distributions kernels.
+	  Instead of just including optimizations for the selected
+	  x86 variant (e.g. PII, Crusoe or Athlon), include some more
+	  generic optimizations as well. This will make the kernel
+	  perform better on x86 CPUs other than that selected.
+
+	  This is really intended for distributors who need more
+	  generic optimizations.
 
 #
 # Define implied options from the CPU selection here
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Stewart Smith <stewart@linux.org.au>: [resend patch] CONFIG_X86_GENERIC description fixup
