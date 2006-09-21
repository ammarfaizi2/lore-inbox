Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWIULUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWIULUn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 07:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWIULUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 07:20:43 -0400
Received: from free-electrons.com ([88.191.23.47]:16603 "EHLO
	sd-2511.dedibox.fr") by vger.kernel.org with ESMTP id S1750933AbWIULUn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 07:20:43 -0400
From: Michael Opdenacker <michael-lists@free-electrons.com>
Organization: Free Electrons
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.16.18] [TRIVIAL] Spelling fix: "control" instead of "cotrol"
Date: Thu, 21 Sep 2006 13:20:11 +0200
User-Agent: KMail/1.9.1
Cc: trivial@kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609211320.13040.michael-lists@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against Linux 2.6.18 fixes a spelling mistake happening
in the below files ("control" instead of "cotrol")

drivers/net/ne2.c: * bit by bit.  The EEPROM cotrol port at base + 0x1e has 
the following
mm/nommu.c: *   For tight cotrol over page level allocator and protection 
flags
mm/vmalloc.c: * For tight cotrol over page level allocator and protection 
flags
mm/vmalloc.c: * For tight cotrol over page level allocator and protection 
flags
mm/vmalloc.c: * For tight cotrol over page level allocator and protection 
flags

Such comments and spelling mistakes then show up in the automatically 
generated kernel documentation (created by "make htmldocs").

	Michael.

--

Signed-off-by: Michael Opdenacker <michael@free-electrons.com>

diff -Nurp linux-2.6.18/drivers/net/ne2.c 
linux-2.6.18-spelling1/drivers/net/ne2.c
--- linux-2.6.18/drivers/net/ne2.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18-spelling1/drivers/net/ne2.c	2006-09-21 13:07:24.000000000 
+0200
@@ -152,7 +152,7 @@ static void ne_block_output(struct net_d
 /*
  * special code to read the DE-320's MAC address EEPROM.  In contrast to a 
  * standard NE design, this is a serial EEPROM (93C46) that has to be read
- * bit by bit.  The EEPROM cotrol port at base + 0x1e has the following 
+ * bit by bit.  The EEPROM control port at base + 0x1e has the following 
  * layout:
  *
  * Bit 0 = Data out (read from EEPROM)
diff -Nurp linux-2.6.18/mm/nommu.c linux-2.6.18-spelling1/mm/nommu.c
--- linux-2.6.18/mm/nommu.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18-spelling1/mm/nommu.c	2006-09-21 13:07:36.000000000 +0200
@@ -197,7 +197,7 @@ long vwrite(char *buf, char *addr, unsig
  *	Allocate enough pages to cover @size from the page level
  *	allocator and map them into continguos kernel virtual space.
  *
- *	For tight cotrol over page level allocator and protection flags
+ *	For tight control over page level allocator and protection flags
  *	use __vmalloc() instead.
  */
 void *vmalloc(unsigned long size)
diff -Nurp linux-2.6.18/mm/vmalloc.c linux-2.6.18-spelling1/mm/vmalloc.c
--- linux-2.6.18/mm/vmalloc.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18-spelling1/mm/vmalloc.c	2006-09-21 13:07:59.000000000 +0200
@@ -509,7 +509,7 @@ EXPORT_SYMBOL(__vmalloc);
  *	Allocate enough pages to cover @size from the page level
  *	allocator and map them into contiguous kernel virtual space.
  *
- *	For tight cotrol over page level allocator and protection flags
+ *	For tight control over page level allocator and protection flags
  *	use __vmalloc() instead.
  */
 void *vmalloc(unsigned long size)
@@ -549,7 +549,7 @@ EXPORT_SYMBOL(vmalloc_user);
  *	Allocate enough pages to cover @size from the page level
  *	allocator and map them into contiguous kernel virtual space.
  *
- *	For tight cotrol over page level allocator and protection flags
+ *	For tight control over page level allocator and protection flags
  *	use __vmalloc() instead.
  */
 void *vmalloc_node(unsigned long size, int node)
@@ -571,7 +571,7 @@ EXPORT_SYMBOL(vmalloc_node);
  *	the page level allocator and map them into contiguous and
  *	executable kernel virtual space.
  *
- *	For tight cotrol over page level allocator and protection flags
+ *	For tight control over page level allocator and protection flags
  *	use __vmalloc() instead.
  */
 

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1000 pages!)
