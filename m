Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSL2XeA>; Sun, 29 Dec 2002 18:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSL2XeA>; Sun, 29 Dec 2002 18:34:00 -0500
Received: from [81.2.122.30] ([81.2.122.30]:39428 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S262224AbSL2Xd7>;
	Sun, 29 Dec 2002 18:33:59 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212292342.gBTNg9gk000920@darkstar.example.net>
Subject: [TRIVIAL] Fix two mis-spellings of 'kernel'
To: trivial@rustcorp.com.au
Date: Sun, 29 Dec 2002 23:42:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.883.1041205329--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.883.1041205329--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Patches against 2.5.53 to fix two mis-spellings of 'kernel', in:

arch/mips/kernel/pci.c

and

arch/ppc64/kernel/signal32.c

both also apply to 2.4.20.

John.

--%--multipart-mixed-boundary-1.883.1041205329--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: ASCII text
Content-Disposition: attachment; filename="patch_2"

--- linux-2.5.53-orig/arch/ppc64/kernel/signal32.c	2002-12-29 23:15:07.000000000 +0000
+++ linux-2.5.53/arch/ppc64/kernel/signal32.c	2002-12-29 23:36:51.000000000 +0000
@@ -57,7 +57,7 @@
 struct sigregs32 {
 	/*
 	 * the gp_regs array is 32 bit representation of the pt_regs
-	 * structure that was stored on the kernle stack during the
+	 * structure that was stored on the kernel stack during the
 	 * system call that was interrupted for the signal.
 	 *
 	 * Note that the entire pt_regs regs structure will fit in

--%--multipart-mixed-boundary-1.883.1041205329--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: ASCII text
Content-Disposition: attachment; filename="patch_1"

--- linux-2.5.53-orig/arch/mips/kernel/pci.c	2002-12-29 23:15:03.000000000 +0000
+++ linux-2.5.53/arch/mips/kernel/pci.c	2002-12-29 23:36:17.000000000 +0000
@@ -3,7 +3,7 @@
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
  *
  * Modified to be mips generic, ppopov@mvista.com
- * arch/mips/kernl/pci.c
+ * arch/mips/kernel/pci.c
  *     Common MIPS PCI routines.
  *
  * This program is free software; you can redistribute  it and/or modify it

--%--multipart-mixed-boundary-1.883.1041205329--%--
