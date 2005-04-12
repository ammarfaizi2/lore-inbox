Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVDMBaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVDMBaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVDLTxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:53:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:47816 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262163AbVDLKbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:51 -0400
Message-Id: <200504121031.j3CAVYAU005344@shell0.pdx.osdl.net>
Subject: [patch 055/198] mips: remove obsolete VR41xx RTC function  from vr41xx.h
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, yuasa@hh.iij4u.or.jp,
       ralf@linux-mips.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

This patch had removed obsolete VR41xx RTC function from vr41xx.h .  I
forgot to put this change in "update VR41xx RTC support".

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-mips/vr41xx/vr41xx.h |   16 ----------------
 1 files changed, 16 deletions(-)

diff -puN include/asm-mips/vr41xx/vr41xx.h~mips-remove-obsolete-vr41xx-rtc-function include/asm-mips/vr41xx/vr41xx.h
--- 25/include/asm-mips/vr41xx/vr41xx.h~mips-remove-obsolete-vr41xx-rtc-function	2005-04-12 03:21:16.575617024 -0700
+++ 25-akpm/include/asm-mips/vr41xx/vr41xx.h	2005-04-12 03:21:16.578616568 -0700
@@ -198,22 +198,6 @@ extern void vr41xx_enable_bcuint(void);
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
_
