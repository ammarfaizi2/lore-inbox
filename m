Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWDFURR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWDFURR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 16:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWDFURR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 16:17:17 -0400
Received: from xenotime.net ([66.160.160.81]:1490 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751267AbWDFURQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 16:17:16 -0400
Date: Thu, 6 Apr 2006 13:19:34 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] mptspec: remove duplicate #Include
Message-Id: <20060406131934.de59a875.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Remove duplicate #include line.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/asm-i386/mpspec.h |    1 -
 1 files changed, 1 deletion(-)

--- linux-2617-rc1.orig/include/asm-i386/mpspec.h
+++ linux-2617-rc1/include/asm-i386/mpspec.h
@@ -18,7 +18,6 @@ extern void find_smp_config (void);
 extern void get_smp_config (void);
 extern int nr_ioapics;
 extern int apic_version [MAX_APICS];
-extern int mp_bus_id_to_type [MAX_MP_BUSSES];
 extern int mp_irq_entries;
 extern struct mpc_config_intsrc mp_irqs [MAX_IRQ_SOURCES];
 extern int mpc_default_type;


---
