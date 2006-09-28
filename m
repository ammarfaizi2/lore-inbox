Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161112AbWI1NIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161112AbWI1NIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965417AbWI1NIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:08:04 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:1341 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S965416AbWI1NIB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:08:01 -0400
Date: Thu, 28 Sep 2006 15:07:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cborntra@de.ibm.com
Subject: [S390] remove unnecessary includes.
Message-ID: <20060928130758.GC1120@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[S390] remove unnecessary includes.

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/fs3270.c |    1 -
 1 files changed, 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/char/fs3270.c linux-2.6-patched/drivers/s390/char/fs3270.c
--- linux-2.6/drivers/s390/char/fs3270.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/fs3270.c	2006-09-28 14:58:53.000000000 +0200
@@ -17,7 +17,6 @@
 
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
-#include <asm/cpcmd.h>
 #include <asm/ebcdic.h>
 #include <asm/idals.h>
 
