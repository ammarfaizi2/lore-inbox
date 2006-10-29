Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWJ2Dlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWJ2Dlh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 23:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWJ2Dlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 23:41:37 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:28263 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964961AbWJ2Dlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 23:41:36 -0400
Date: Sat, 28 Oct 2006 20:36:56 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>, dwmw2@infradead.org
Subject: [PATCH] MTD: fix last kernel-doc warning
Message-Id: <20061028203656.062d9075.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix the last current kernel-doc warning:
Warning(/var/linsrc/linux-2619-rc3g5//include/linux/mtd/nand.h:416): No description found for parameter 'write_page'


Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 include/linux/mtd/nand.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2619-rc3g5.orig/include/linux/mtd/nand.h
+++ linux-2619-rc3g5/include/linux/mtd/nand.h
@@ -355,7 +355,7 @@ struct nand_buffers {
  * @priv:		[OPTIONAL] pointer to private chip date
  * @errstat:		[OPTIONAL] hardware specific function to perform additional error status checks
  *			(determine if errors are correctable)
- * @write_page		[REPLACEABLE] High-level page write function
+ * @write_page:		[REPLACEABLE] High-level page write function
  */
 
 struct nand_chip {


---
