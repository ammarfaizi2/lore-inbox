Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVCOSYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVCOSYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVCOSVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:21:49 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:63148 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261701AbVCOSVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:21:12 -0500
Date: Tue, 15 Mar 2005 11:20:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ppc32: Fix a typo on 8260
Message-ID: <20050315182047.GV8345@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a lingering typo in arch/ppc/boot/simple/m8260_tty.c

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff -urN linux-2.6.11/arch/ppc/boot/simple/m8260_tty.c linuxppc-2.6.11/arch/ppc/boot/simple/m8260_tty.c
--- linux-2.6.11/arch/ppc/boot/simple/m8260_tty.c	2005-03-02 00:37:54.000000000 -0700
+++ linuxppc-2.6.11/arch/ppc/boot/simple/m8260_tty.c	2005-03-15 08:56:44.000000000 -0700
@@ -159,7 +159,7 @@
 	sccp->scc_sccm = 0;
 	sccp->scc_scce = 0xffff;
 	sccp->scc_dsr = 0x7e7e;
-	sccp->scc_pmsr = 0x3000;
+	sccp->scc_psmr = 0x3000;
 
 	/* Wire BRG1 to SCC1.  The console driver will take care of
 	 * others.

-- 
Tom Rini
http://gate.crashing.org/~trini/
