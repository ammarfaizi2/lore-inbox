Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbTEZGf7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 02:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTEZGf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 02:35:56 -0400
Received: from dp.samba.org ([66.70.73.150]:63888 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264299AbTEZGft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 02:35:49 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: davem@redhat.com, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] [2.5 patch] small documentation apdate regarding supported gcc versions
Date: Mon, 26 May 2003 16:32:04 +1000
Message-Id: <20030526064901.074712C0D8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Looks correct given the check in init/main.c. --RR ]
From:  Adrian Bunk <bunk@fs.tum.de>

  The patch below against 2.5.68-bk11 contains a small documentation 
  apdate regarding supported gcc versions.
  
  cu
  Adrian
  

--- trivial-2.5.69-bk18/README.orig	2003-05-26 16:17:24.000000000 +1000
+++ trivial-2.5.69-bk18/README	2003-05-26 16:17:24.000000000 +1000
@@ -152,9 +152,8 @@
 
 COMPILING the kernel:
 
- - Make sure you have gcc 2.95.3 available.
-   gcc 2.91.66 (egcs-1.1.2), and gcc 2.7.2.3 are known to miscompile
-   some parts of the kernel, and are *no longer supported*.
+ - Make sure you have gcc >= 2.95.3 available. *gcc 2.7.2.3 and gcc 2.91.66
+   (egcs-1.1.2) are no longer supported*.
    Also remember to upgrade your binutils package (for as/ld/nm and company)
    if necessary. For more information, refer to ./Documentation/Changes.
 
--- trivial-2.5.69-bk18/Documentation/Changes.orig	2003-05-26 16:17:24.000000000 +1000
+++ trivial-2.5.69-bk18/Documentation/Changes	2003-05-26 16:17:24.000000000 +1000
@@ -76,15 +76,13 @@
 information about their gcc version requirements from another source.
 
 The recommended compiler for the kernel is gcc 2.95.x (x >= 3), and it
-should be used when you need absolute stability. You may use gcc 3.0.x
+should be used when you need absolute stability. You may use gcc 3.x
 instead if you wish, although it may cause problems. Later versions of gcc 
 have not received much testing for Linux kernel compilation, and there are 
 almost certainly bugs (mainly, but not exclusively, in the kernel) that
 will need to be fixed in order to use these compilers. In any case, using
 pgcc instead of plain gcc is just asking for trouble.
 
-gcc 2.91.66 (egcs-1.1.2) continues to be supported for SPARC64 requirements.
-
 The Red Hat gcc 2.96 compiler subtree can also be used to build this tree.
 You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not build
 the kernel correctly.
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Adrian Bunk <bunk@fs.tum.de>: [2.5 patch] small documentation apdate regarding supported gcc versions
