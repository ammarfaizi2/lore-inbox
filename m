Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbTFWHJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTFWHJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:09:59 -0400
Received: from dp.samba.org ([66.70.73.150]:34741 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264188AbTFWHJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:09:54 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] [resend patch] CONFIG_X86_GENERIC description fixup
Date: Mon, 23 Jun 2003 17:19:06 +1000
Message-Id: <20030623072401.577D62C2E7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Stewart Smith <stewart@linux.org.au>

  as per thread on lkml a little while ago, a better explanation
  of the X86_GENERIC config option follows. The person who questioned
  it originally seemed to like this improved version, so that's one point :)
  
  

--- trivial-2.5.73/arch/i386/Kconfig.orig	2003-06-23 17:04:46.000000000 +1000
+++ trivial-2.5.73/arch/i386/Kconfig	2003-06-23 17:04:46.000000000 +1000
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
