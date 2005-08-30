Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbVH3ODM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbVH3ODM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVH3ODM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:03:12 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:50641 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1751437AbVH3ODL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:03:11 -0400
Date: Tue, 30 Aug 2005 23:03:03 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] mips: remove timex.h for vr41xx
Message-Id: <20050830230303.24d61e2b.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

vr41xx doesn't need mach-vr41xx/timex.h.
This patch has removed mach-vr41xx/timex.h.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff rc6-mm2-orig/include/asm-mips/mach-vr41xx/timex.h rc6-mm2/include/asm-mips/mach-vr41xx/timex.h
--- rc6-mm2-orig/include/asm-mips/mach-vr41xx/timex.h	2005-08-08 03:18:56.000000000 +0900
+++ rc6-mm2/include/asm-mips/mach-vr41xx/timex.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,18 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2003 by Ralf Baechle
- */
-/*
- * Changes:
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  - CLOCK_TICK_RATE is changed into 32768 from 6144000.
- */
-#ifndef __ASM_MACH_VR41XX_TIMEX_H
-#define __ASM_MACH_VR41XX_TIMEX_H
-
-#define CLOCK_TICK_RATE		32768
-
-#endif /* __ASM_MACH_VR41XX_TIMEX_H */
