Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbTIDDce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264619AbTIDDbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:31:03 -0400
Received: from dp.samba.org ([66.70.73.150]:25024 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264625AbTIDDaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:30:20 -0400
From: Rusty Trivial Russell <trivial@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] [resend patch] CONFIG_X86_GENERIC description fixup
Date: Thu, 04 Sep 2003 13:26:41 +1000
Message-Id: <20030904033019.794AD2C0B1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Stewart Smith <stewart@linux.org.au>

  as per thread on lkml a little while ago, a better explanation
  of the X86_GENERIC config option follows. The person who questioned
  it originally seemed to like this improved version, so that's one point :)
  
  

--- trivial-2.6.0-test4-bk5/arch/i386/Kconfig.orig	2003-09-04 13:02:02.000000000 +1000
+++ trivial-2.6.0-test4-bk5/arch/i386/Kconfig	2003-09-04 13:02:02.000000000 +1000
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
