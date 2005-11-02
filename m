Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbVKBSeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbVKBSeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbVKBSeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:34:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28178 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965166AbVKBSeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:34:16 -0500
Date: Wed, 2 Nov 2005 19:34:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] Documentation/arm/README: small update
Message-ID: <20051102183415.GF4272@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- egcs is not supported by kernel 2.6
- gcc 3.3 seems to be a good choice on ARM


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 3 Sep 2005

--- linux-2.6.13-mm1-full/Documentation/arm/README.old	2005-09-03 00:02:55.000000000 +0200
+++ linux-2.6.13-mm1-full/Documentation/arm/README	2005-09-03 00:03:51.000000000 +0200
@@ -8,10 +8,9 @@
 ---------------------
 
   In order to compile ARM Linux, you will need a compiler capable of
-  generating ARM ELF code with GNU extensions.  GCC 2.95.1, EGCS
-  1.1.2, and GCC 3.3 are known to be good compilers.  Fortunately, you
-  needn't guess.  The kernel will report an error if your compiler is
-  a recognized offender.
+  generating ARM ELF code with GNU extensions.  GCC 3.3 is known to be
+  a good compiler.  Fortunately, you needn't guess.  The kernel will report
+  an error if your compiler is a recognized offender.
 
   To build ARM Linux natively, you shouldn't have to alter the ARCH = line
   in the top level Makefile.  However, if you don't have the ARM Linux ELF

