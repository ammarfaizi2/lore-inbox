Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVDCOAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVDCOAB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 10:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVDCOAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 10:00:01 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:43004 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261739AbVDCN76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 09:59:58 -0400
Date: Sun, 3 Apr 2005 22:59:45 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12-rc1-mm4] mips: remove obsolete VR41xx RTC function
 from vr41xx.h
Message-Id: <20050403225945.60c1e751.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had removed obsolete VR41xx RTC function from vr41xx.h .
I forgot to put this change in "update VR41xx RTC support".

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff rc1-mm4-orig/include/asm-mips/vr41xx/vr41xx.h rc1-mm4/include/asm-mips/vr41xx/vr41xx.h
--- rc1-mm4-orig/include/asm-mips/vr41xx/vr41xx.h	Fri Apr  1 21:21:37 2005
+++ rc1-mm4/include/asm-mips/vr41xx/vr41xx.h	Sat Apr  2 19:26:58 2005
@@ -198,22 +198,6 @@
 extern void vr41xx_disable_bcuint(void);
 
 /*
- * Power Management Unit
- */
-
-/*
- * RTC
- */
-extern void vr41xx_set_rtclong1_cycle(uint32_t cycles);
-extern uint32_t vr41xx_read_rtclong1_counter(void);
-
-extern void vr41xx_set_rtclong2_cycle(uint32_t cycles);
-extern uint32_t vr41xx_read_rtclong2_counter(void);
-
-extern void vr41xx_set_tclock_cycle(uint32_t cycles);
-extern uint32_t vr41xx_read_tclock_counter(void);
-
-/*
  * General-Purpose I/O Unit
  */
 enum {


