Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVHKPSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVHKPSF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVHKPSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:18:05 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:7660 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1751079AbVHKPR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:17:56 -0400
Date: Fri, 12 Aug 2005 00:17:51 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][4/4] mips: changed from VR41xx to VR4100 series in Kconfig
Message-Id: <20050812001751.23eba0f8.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has changed from VR41XX to VR4100 series in arch/mips/Kconfig.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm1-orig/arch/mips/Kconfig mm1/arch/mips/Kconfig
--- mm1-orig/arch/mips/Kconfig	2005-08-11 23:47:04.000000000 +0900
+++ mm1/arch/mips/Kconfig	2005-08-11 23:46:44.000000000 +0900
@@ -71,7 +71,7 @@
 	  <http://www.linux-mips.org/>.
 
 config MACH_VR41XX
-	bool "Support for NEC VR41XX-based machines"
+	bool "Support for NEC VR4100 series based machines"
 
 config NEC_CMBVR4133
 	bool "Support for NEC CMB-VR4133"
