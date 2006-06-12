Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWFLHCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWFLHCc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 03:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWFLHCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 03:02:32 -0400
Received: from www.osadl.org ([213.239.205.134]:53418 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751408AbWFLHCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 03:02:31 -0400
Message-ID: <448D117D.9020304@tglx.de>
Date: Mon, 12 Jun 2006 09:02:21 +0200
From: Jan Altenberg <tb10alj@tglx.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: geert@linux-m68k.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][M68K]Trivial typo fix
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

by chance I came across this little typo in asm/ptrace.h
for the m68knommu architecture.

It doesn't affect me, but maybe it'll affect somebody out there.

See the following patch against 2.6.17-rc6.


Signed-off-by: Jan Altenberg <tb10alj@tglx.de>

----------------------

--- linux-2.6.17-rc6/include/asm-m68knommu/ptrace.h.orig	2006-06-12 08:49:51.000000000 +0200
+++ linux-2.6.17-rc6/include/asm-m68knommu/ptrace.h	2006-06-12 08:50:11.000000000 +0200
@@ -70,7 +70,7 @@ struct switch_stack {
 /* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
 #define PTRACE_GETREGS            12
 #define PTRACE_SETREGS            13
-#ifdef COFNIG_FPU
+#ifdef CONFIG_FPU
 #define PTRACE_GETFPREGS          14
 #define PTRACE_SETFPREGS          15
 #endif
