Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUGRUC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUGRUC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 16:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbUGRUCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 16:02:55 -0400
Received: from web53806.mail.yahoo.com ([206.190.36.201]:36481 "HELO
	web53806.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262380AbUGRUCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 16:02:54 -0400
Message-ID: <20040718200254.95356.qmail@web53806.mail.yahoo.com>
Date: Sun, 18 Jul 2004 13:02:54 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent funcs in i386 FPU emulator files
To: lkml <linux-kernel@vger.kernel.org>
Cc: billm@suburbia.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/arch/i386/math-emu/fpu_proto.h
linux-2.6.7-new/arch/i386/math-emu/fpu_proto.h
--- linux-2.6.7-orig/arch/i386/math-emu/fpu_proto.h     2004-06-15 22:20:03.000000000 -0700
+++ linux-2.6.7-new/arch/i386/math-emu/fpu_proto.h      2004-07-18 08:54:29.000000000 -0700
@@ -69,7 +69,6 @@
 extern void FPU_pop(void);
 extern int FPU_empty_i(int stnr);
 extern int FPU_stackoverflow(FPU_REG **st_new_ptr);
-extern void FPU_sync_tags(void);
 extern void FPU_copy_to_regi(FPU_REG const *r, u_char tag, int stnr);
 extern void FPU_copy_to_reg1(FPU_REG const *r, u_char tag);
 extern void FPU_copy_to_reg0(FPU_REG const *r, u_char tag);

