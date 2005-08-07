Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751642AbVHGNgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbVHGNgf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 09:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbVHGNgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 09:36:35 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:29677 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1751670AbVHGNge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 09:36:34 -0400
Date: Sun, 7 Aug 2005 22:36:16 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: moreover remove vr4181
Message-Id: <20050807223616.65af438d.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050807014214.45968af3.akpm@osdl.org>
References: <20050807014214.45968af3.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We also need this patch for removing mips vr4181.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm1-orig/arch/mips/Makefile mm1/arch/mips/Makefile
--- mm1-orig/arch/mips/Makefile	2005-08-07 22:15:17.000000000 +0900
+++ mm1/arch/mips/Makefile	2005-08-07 22:08:19.000000000 +0900
@@ -469,13 +469,6 @@
 load-$(CONFIG_LASAT)		+= 0xffffffff80000000
 
 #
-# NEC Osprey (vr4181) board
-#
-core-$(CONFIG_NEC_OSPREY)	+= arch/mips/vr4181/common/ \
-				   arch/mips/vr4181/osprey/
-load-$(CONFIG_NEC_OSPREY)	+= 0xffffffff80002000
-
-#
 # Common VR41xx
 #
 core-$(CONFIG_MACH_VR41XX)	+= arch/mips/vr41xx/common/


