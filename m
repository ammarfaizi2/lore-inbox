Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266110AbUFEAQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbUFEAQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 20:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266108AbUFEANW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 20:13:22 -0400
Received: from mail.dif.dk ([193.138.115.101]:37071 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266112AbUFEALt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 20:11:49 -0400
Date: Sat, 5 Jun 2004 02:11:11 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] Trivial, add missing newline at EOF in arch/i386/pci/changelog
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC082C7F8C@difpst1a.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Missing newlines at the end of files make them less pleasing to work with
for a number of tools that work on a line-by-line basis, and for source files
it will cause gcc to emit a warning. So, I desided to add that missing
newline to the few files in the kernel that are missing it.
This patch makes no functional changes at all to the kernel.
Patch is against 2.6.7-rc2

Here's the patch adding a newline to arch/i386/pci/changelog


--- linux-2.6.7-rc2/arch/i386/pci/changelog-orig	2004-06-05 01:27:24.000000000 +0200
+++ linux-2.6.7-rc2/arch/i386/pci/changelog	2004-06-05 01:29:39.000000000 +0200
@@ -59,4 +59,4 @@
  *		  for a lot of patience during testing. [mj]
  *
  * Oct  8, 1999 : Split to pci-i386.c, pci-pc.c and pci-visws.c. [mj]
- */
\ No newline at end of file
+ */


--
Jesper Juhl <juhl-lkml@dif.dk>
