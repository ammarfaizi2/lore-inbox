Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbUKDCOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbUKDCOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUKDCJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:09:16 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:61587
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262046AbUKDBzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:24 -0500
Subject: [patch 06/20] uml: remove useless inclusion
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:28 +0100
Message-Id: <20041103231728.550C64F6D2@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid including some unused headers.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/main.c                  |    2 ++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/mmu-skas.h |    3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff -puN arch/um/kernel/skas/include/mmu-skas.h~uml-remove-useless-inclusion arch/um/kernel/skas/include/mmu-skas.h
--- vanilla-linux-2.6.9/arch/um/kernel/skas/include/mmu-skas.h~uml-remove-useless-inclusion	2004-11-03 23:44:58.287699040 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/mmu-skas.h	2004-11-03 23:44:58.291698432 +0100
@@ -6,9 +6,6 @@
 #ifndef __SKAS_MMU_H
 #define __SKAS_MMU_H
 
-#include "linux/list.h"
-#include "linux/spinlock.h"
-
 struct mmu_context_skas {
 	int mm_fd;
 };
diff -puN arch/um/kernel/main.c~uml-remove-useless-inclusion arch/um/kernel/main.c
--- vanilla-linux-2.6.9/arch/um/kernel/main.c~uml-remove-useless-inclusion	2004-11-03 23:44:58.288698888 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/main.c	2004-11-03 23:44:58.291698432 +0100
@@ -17,6 +17,8 @@
 #include "kern_util.h"
 #include "mem_user.h"
 #include "signal_user.h"
+#include "time_user.h"
+#include "irq_user.h"
 #include "user.h"
 #include "init.h"
 #include "mode.h"
_
