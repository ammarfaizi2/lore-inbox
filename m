Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVFAGvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVFAGvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 02:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVFAGvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 02:51:24 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:22463 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261301AbVFAGvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 02:51:17 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: marcelo@hera.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: PATCH 2.4.31: update pci.ids 1of2
Date: Wed, 01 Jun 2005 16:51:08 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <njkq9190or749nc0qnebit5fu1380ebpvv@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

This patch updates kernel copy of pci.ids from 2003-05-30 03:13:05 
to current version dated 2005-05-27 07:00:10.  Also changed is an 
increase from 79 to 160 string length (current longest line is 142)

Part 2of2 is 73KB gzip'd diff of the old/new pci.ids, not to list :)

Compile / boot tested.

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 gen-devlist.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.31/drivers/pci/gen-devlist.c	2002-08-03 10:39:44.000000000 +1000
+++ linux-2.4.31-sp-a/drivers/pci/gen-devlist.c	2005-06-01 15:48:16.000000000 +1000
@@ -7,7 +7,7 @@
 #include <stdio.h>
 #include <string.h>
 
-#define MAX_NAME_SIZE 79
+#define MAX_NAME_SIZE 160
 
 static void
 pq(FILE *f, const char *c)
