Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTEBPot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 11:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbTEBPot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 11:44:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42436 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262955AbTEBPos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 11:44:48 -0400
Date: Fri, 2 May 2003 17:57:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [2.5 patch] small documentation apdate regarding supported gcc versions
Message-ID: <20030502155706.GT21168@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below against 2.5.68-bk11 contains a small documentation 
apdate regarding supported gcc versions.

cu
Adrian

--- linux-2.5.68-bk11/README.old	2003-05-02 17:47:22.000000000 +0200
+++ linux-2.5.68-bk11/README	2003-05-02 17:48:12.000000000 +0200
@@ -152,9 +152,8 @@
 
 COMPILING the kernel:
 
- - Make sure you have gcc 2.95.3 available.
-   gcc 2.91.66 (egcs-1.1.2), and gcc 2.7.2.3 are known to miscompile
-   some parts of the kernel, and are *no longer supported*.
+ - Make sure you have gcc >= 2.95.3 available. *gcc 2.7.2.3 and gcc 2.91.66
+   (egcs-1.1.2) are no longer supported*.
    Also remember to upgrade your binutils package (for as/ld/nm and company)
    if necessary. For more information, refer to ./Documentation/Changes.
 
--- linux-2.5.68-bk11/Documentation/Changes.old	2003-05-02 17:48:51.000000000 +0200
+++ linux-2.5.68-bk11/Documentation/Changes	2003-05-02 17:50:16.000000000 +0200
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
