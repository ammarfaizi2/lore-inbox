Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266293AbUFYGap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUFYGap (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 02:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUFYG30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 02:29:26 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:41210 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266242AbUFYG3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 02:29:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Add missing end-of-line backslash to v850 vmlinux.lds.S
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20040625062900.A731D3AC@mctpc71>
Date: Fri, 25 Jun 2004 15:29:00 +0900 (JST)
From: miles@mctpc71.ucom.lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/kernel/vmlinux.lds.S |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -ruN -X../cludes linux-2.6.7-uc0/arch/v850/kernel/vmlinux.lds.S linux-2.6.7-uc0-v850-20040625/arch/v850/kernel/vmlinux.lds.S
--- linux-2.6.7-uc0/arch/v850/kernel/vmlinux.lds.S	2004-06-24 17:05:03.000000000 +0900
+++ linux-2.6.7-uc0-v850-20040625/arch/v850/kernel/vmlinux.lds.S	2004-06-24 17:20:36.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/vmlinux.lds.S -- kernel linker script for v850 platforms
  *
- *  Copyright (C) 2002,03  NEC Electronics Corporation
- *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2002,03,04  NEC Electronics Corporation
+ *  Copyright (C) 2002,03,04  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -65,7 +65,7 @@
 #define TEXT_CONTENTS							      \
 		__stext = . ;						      \
         	*(.text)						      \
-		SCHED_TEXT
+		SCHED_TEXT						      \
 			*(.exit.text)	/* 2.5 convention */		      \
 			*(.text.exit)	/* 2.4 convention */		      \
 			*(.text.lock)					      \
