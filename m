Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWIOTbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWIOTbH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWIOTbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:31:07 -0400
Received: from mail.windriver.com ([147.11.1.11]:57774 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id S1751388AbWIOTbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:31:05 -0400
Date: Fri, 15 Sep 2006 15:31:03 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix typo in cpm2.h
Message-ID: <20060915193103.GA25579@lucciola.windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Amy Fong <amy.fong@windriver.com>
X-OriginalArrivalTime: 15 Sep 2006 19:31:04.0349 (UTC) FILETIME=[7BE3CCD0:01C6D8FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[PATCH] fix typo in cpm2.h

Kernel version: linux-2.6.18-rc6

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fcc-fix.diff"

Index: linux-2.6.18-rc6/include/asm-ppc/cpm2.h
===================================================================
--- linux-2.6.18-rc6.orig/include/asm-ppc/cpm2.h
+++ linux-2.6.18-rc6/include/asm-ppc/cpm2.h
@@ -1186,7 +1186,7 @@
 #define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
 #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
 #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
-#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(2)
+#define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
 
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */

--zhXaljGHf11kAtnf--
