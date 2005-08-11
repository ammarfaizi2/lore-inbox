Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVHKPRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVHKPRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVHKPRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:17:43 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:47860 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1751079AbVHKPRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:17:42 -0400
Date: Fri, 12 Aug 2005 00:17:36 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][3/4] mips: remove vrc4171 config
Message-Id: <20050812001736.6609c040.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has removed obsolete VRC4171 config.
Please apply.

Yoichi

diff -urN -X dontdiff mm1-orig/arch/mips/Kconfig mm1/arch/mips/Kconfig
--- mm1-orig/arch/mips/Kconfig	2005-08-11 23:39:49.000000000 +0900
+++ mm1/arch/mips/Kconfig	2005-08-11 23:40:22.000000000 +0900
@@ -153,12 +153,6 @@
 	bool "Add PCI control unit support of NEC VR4100 series"
 	depends on MACH_VR41XX && PCI
 
-config VRC4171
-	tristate "Add NEC VRC4171 companion chip support"
-	depends on MACH_VR41XX && ISA
-	---help---
-	  The NEC VRC4171/4171A is a companion chip for NEC VR4111/VR4121.
-
 config VRC4173
 	tristate "Add NEC VRC4173 companion chip support"
 	depends on MACH_VR41XX && PCI_VR41XX
