Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVCEWlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVCEWlf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVCEWle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:41:34 -0500
Received: from coderock.org ([193.77.147.115]:25509 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261269AbVCEWlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:41:24 -0500
Subject: [patch 1/4] delete unused file include_asm_arm_arch_epxa10db_mode_ctrl00.h
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:41:14 +0100
Message-Id: <20050305224115.A6D211EE1E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/include/asm-arm/arch-epxa10db/mode_ctrl00.h |   80 -------------------------
 1 files changed, 80 deletions(-)

diff -L include/asm-arm/arch-epxa10db/mode_ctrl00.h -puN include/asm-arm/arch-epxa10db/mode_ctrl00.h~remove_file-include_asm_arm_arch_epxa10db_mode_ctrl00.h /dev/null
--- kj/include/asm-arm/arch-epxa10db/mode_ctrl00.h
+++ /dev/null	2005-03-02 11:34:59.000000000 +0100
@@ -1,80 +0,0 @@
-#ifndef __MODE_CTRL00_H
-#define __MODE_CTRL00_H
-
-/*
- * Register definitions for the reset and mode control
- */
-
-/*
- *  Copyright (C) 2001 Altera Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-
-
-#define BOOT_CR(BASE_ADDR) (MODE_CTRL00_TYPE (BASE_ADDR  ))
-#define BOOT_CR_BF_MSK (0x1)
-#define BOOT_CR_BF_OFST (0)
-#define BOOT_CR_HM_MSK (0x2)
-#define BOOT_CR_HM_OFST (1)
-#define BOOT_CR_RE_MSK (0x4)
-#define BOOT_CR_RE_OFST (2)
-
-#define RESET_SR(BASE_ADDR) (MODE_CTRL00_TYPE (BASE_ADDR  + 0x4 ))
-#define RESET_SR_WR_MSK (0x1)
-#define RESET_SR_WR_OFST (0)
-#define RESET_SR_CR_MSK (0x2)
-#define RESET_SR_CR_OFST (1)
-#define RESET_SR_JT_MSK (0x4)
-#define RESET_SR_JT_OFST (2)
-#define RESET_SR_ER_MSK (0x8)
-#define RESET_SR_ER_OFST (3)
-
-#define ID_CODE(BASE_ADDR) (MODE_CTRL00_TYPE (BASE_ADDR  + 0x08 ))
-
-#define SRAM0_SR(BASE_ADDR) (MODE_CTRL00_TYPE (BASE_ADDR  + 0x20 ))
-#define SRAM0_SR_SIZE_MSK (0xFFFFF000)
-#define SRAM0_SR_SIZE_OFST (12)
-
-#define SRAM1_SR(BASE_ADDR) (MODE_CTRL00_TYPE (BASE_ADDR  + 0x24 ))
-#define SRAM1_SR_SIZE_MSK (0xFFFFF000)
-#define SRAM1_SR_SIZE_OFST (12)
-
-#define DPSRAM0_SR(BASE_ADDR) (MODE_CTRL00_TYPE (BASE_ADDR  + 0x30 ))
-
-#define DPSRAM0_SR_MODE_MSK (0xF)
-#define DPSRAM0_SR_MODE_OFST (0)
-#define DPSRAM0_SR_GLBL_MSK (0x30)
-#define DPSRAM0_SR_SIZE_MSK (0xFFFFF000)
-#define DPSRAM0_SR_SIZE_OFST (12)
-
-#define DPSRAM0_LCR(BASE_ADDR) (MODE_CTRL00_TYPE (BASE_ADDR  + 0x34 ))
-#define DPSRAM0_LCR_LCKADDR_MSK (0x1FFE0)
-#define DPSRAM0_LCR_LCKADDR_OFST (4)
-
-#define DPSRAM1_SR(BASE_ADDR) (MODE_CTRL00_TYPE (BASE_ADDR  + 0x38 ))
-#define DPSRAM1_SR_MODE_MSK (0xF)
-#define DPSRAM1_SR_MODE_OFST (0)
-#define DPSRAM1_SR_GLBL_MSK (0x30)
-#define DPSRAM1_SR_GLBL_OFST (4)
-#define DPSRAM1_SR_SIZE_MSK (0xFFFFF000)
-#define DPSRAM1_SR_SIZE_OFST (12)
-
-#define DPSRAM1_LCR(BASE_ADDR) (MODE_CTRL00_TYPE (BASE_ADDR  + 0x3C ))
-#define DPSRAM1_LCR_LCKADDR_MSK (0x1FFE0)
-#define DPSRAM1_LCR_LCKADDR_OFST (4)
-
-#endif /* __MODE_CTRL00_H */
_
