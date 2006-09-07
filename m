Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWIGMCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWIGMCJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 08:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWIGMCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 08:02:08 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:1454 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751547AbWIGMCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 08:02:05 -0400
Date: Thu, 7 Sep 2006 14:02:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cborntra@de.ibm.com
Subject: [patch] s390: fix typo in vmcp.
Message-ID: <20060907120201.GB6997@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[S390] fix typo in vmcp.

Fix comment typo in vmcp, it is z/VM and not v/VM.

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmcp.c |    2 +-
 drivers/s390/char/vmcp.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/vmcp.c linux-2.6-patched/drivers/s390/char/vmcp.c
--- linux-2.6/drivers/s390/char/vmcp.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/vmcp.c	2006-09-07 12:39:26.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2004,2005 IBM Corporation
- * Interface implementation for communication with the v/VM control program
+ * Interface implementation for communication with the z/VM control program
  * Author(s): Christian Borntraeger <cborntra@de.ibm.com>
  *
  *
diff -urpN linux-2.6/drivers/s390/char/vmcp.h linux-2.6-patched/drivers/s390/char/vmcp.h
--- linux-2.6/drivers/s390/char/vmcp.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/vmcp.h	2006-09-07 12:39:26.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2004, 2005 IBM Corporation
- * Interface implementation for communication with the v/VM control program
+ * Interface implementation for communication with the z/VM control program
  * Version 1.0
  * Author(s): Christian Borntraeger <cborntra@de.ibm.com>
  *
