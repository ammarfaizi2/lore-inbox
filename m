Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVJMT5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVJMT5R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbVJMT5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:57:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19613 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751196AbVJMT5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:57:14 -0400
Date: Thu, 13 Oct 2005 15:57:12 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] remove needless declaration
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0510131554560.23357@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


They aren't used anywhere in that file.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/lib/extable.c b/lib/extable.c
index 3f677a8..18df57c 100644
--- a/lib/extable.c
+++ b/lib/extable.c
@@ -16,9 +16,6 @@
 #include <linux/sort.h>
 #include <asm/uaccess.h>
 
-extern struct exception_table_entry __start___ex_table[];
-extern struct exception_table_entry __stop___ex_table[];
-
 #ifndef ARCH_HAS_SORT_EXTABLE
 /*
  * The exception table needs to be sorted so that the binary
