Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266049AbUFEAKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUFEAKC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 20:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266105AbUFEAKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 20:10:02 -0400
Received: from mail.dif.dk ([193.138.115.101]:27343 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266049AbUFEAJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 20:09:59 -0400
Date: Sat, 5 Jun 2004 02:09:20 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] Trivial, add missing newline at EOF in
 Documentation/networking/packet_mmap.txt
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC082C7F88@difpst1a.dif.dk>
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

Here's the patch adding a newline to Documentation/networking/packet_mmap.txt


--- linux-2.6.7-rc2/Documentation/networking/packet_mmap.txt-orig	2004-06-05 01:45:05.000000000 +0200
+++ linux-2.6.7-rc2/Documentation/networking/packet_mmap.txt	2004-06-05 01:45:22.000000000 +0200
@@ -409,4 +409,4 @@ then poll for frames.
 -
 To unsubscribe from this list: send the line "unsubscribe linux-net" in
 the body of a message to majordomo@vger.kernel.org
-More majordomo info at  http://vger.kernel.org/majordomo-info.html
\ No newline at end of file
+More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
Jesper Juhl <juhl-lkml@dif.dk>
