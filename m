Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266105AbUFEAKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266105AbUFEAKa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 20:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbUFEAKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 20:10:30 -0400
Received: from mail.dif.dk ([193.138.115.101]:29647 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266105AbUFEAKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 20:10:25 -0400
Date: Sat, 5 Jun 2004 02:09:46 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] Trivial, add missing newline at EOF in drivers/tc/lk201.h
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC082C7F89@difpst1a.dif.dk>
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

Here's the patch adding a newline to drivers/tc/lk201.h


--- linux-2.6.7-rc2/drivers/tc/lk201.h-orig	2004-06-05 01:36:33.000000000 +0200
+++ linux-2.6.7-rc2/drivers/tc/lk201.h	2004-06-05 01:38:28.000000000 +0200
@@ -50,4 +50,4 @@
 #define LK_KEY_REPEAT 180
 #define LK_KEY_ACK 186

-extern unsigned char scancodeRemap[256];
\ No newline at end of file
+extern unsigned char scancodeRemap[256];


--
Jesper Juhl <juhl-lkml@dif.dk>
