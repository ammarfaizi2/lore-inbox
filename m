Return-Path: <linux-kernel-owner+w=401wt.eu-S1752822AbWLOQWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbWLOQWS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbWLOQWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:22:18 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:3540 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbWLOQWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:22:16 -0500
Date: Fri, 15 Dec 2006 17:22:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cborntra@de.ibm.com
Subject: [S390] sclp_cpi module license.
Message-ID: <20061215162202.GE4920@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[S390] sclp_cpi module license.

sclp_cpi is GPL. Make the module not taint the kernel

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp_cpi.c |    2 ++
 1 files changed, 2 insertions(+)

diff -urpN linux-2.6/drivers/s390/char/sclp_cpi.c linux-2.6-patched/drivers/s390/char/sclp_cpi.c
--- linux-2.6/drivers/s390/char/sclp_cpi.c	2006-12-15 16:54:55.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_cpi.c	2006-12-15 16:55:09.000000000 +0100
@@ -49,6 +49,8 @@ static struct sclp_register sclp_cpi_eve
 	.send_mask = EvTyp_CtlProgIdent_Mask
 };
 
+MODULE_LICENSE("GPL");
+
 MODULE_AUTHOR(
 	"Martin Peschke, IBM Deutschland Entwicklung GmbH "
 	"<mpeschke@de.ibm.com>");
