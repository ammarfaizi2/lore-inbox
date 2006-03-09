Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751838AbWCILdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbWCILdv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWCILdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:33:51 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:62315 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751831AbWCILdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:33:50 -0500
Date: Thu, 9 Mar 2006 12:33:37 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Horst Hummel <horst.hummel@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: [patch] s390: dasd proc interface typo
Message-ID: <20060309113337.GB10281@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

This fixes a typo introduced with 90f0094dc607abe384a412bfb7199fb667ab0735.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

This changes a new user space interface and therefore should be merged
before 2.6.16. Or never.

 drivers/s390/block/dasd_proc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_proc.c linux-2.6-patched/drivers/s390/block/dasd_proc.c
--- linux-2.6/drivers/s390/block/dasd_proc.c	2006-03-09 12:24:41.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_proc.c	2006-03-09 12:24:58.000000000 +0100
@@ -94,7 +94,7 @@ dasd_devices_show(struct seq_file *m, vo
 		seq_printf(m, "basic");
 		break;
 	case DASD_STATE_UNFMT:
-		seq_printf(m, "unnformatted");
+		seq_printf(m, "unformatted");
 		break;
 	case DASD_STATE_READY:
 	case DASD_STATE_ONLINE:
