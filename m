Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWCVPQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWCVPQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWCVPQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:16:04 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:54481 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751286AbWCVPQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:16:01 -0500
Date: Wed, 22 Mar 2006 16:16:24 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 5/24] s390: /proc/sys/vm/cmm_* permission bits.
Message-ID: <20060322151624.GE5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 5/24] s390: /proc/sys/vm/cmm_* permission bits.

Set permissoin of /proc/sys/vm/cmm_* files to 0644.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/cmm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/arch/s390/mm/cmm.c linux-2.6-patched/arch/s390/mm/cmm.c
--- linux-2.6/arch/s390/mm/cmm.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/cmm.c	2006-03-22 14:36:14.000000000 +0100
@@ -339,19 +339,19 @@ static struct ctl_table cmm_table[] = {
 	{
 		.ctl_name	= VM_CMM_PAGES,
 		.procname	= "cmm_pages",
-		.mode		= 0600,
+		.mode		= 0644,
 		.proc_handler	= &cmm_pages_handler,
 	},
 	{
 		.ctl_name	= VM_CMM_TIMED_PAGES,
 		.procname	= "cmm_timed_pages",
-		.mode		= 0600,
+		.mode		= 0644,
 		.proc_handler	= &cmm_pages_handler,
 	},
 	{
 		.ctl_name	= VM_CMM_TIMEOUT,
 		.procname	= "cmm_timeout",
-		.mode		= 0600,
+		.mode		= 0644,
 		.proc_handler	= &cmm_timeout_handler,
 	},
 	{ .ctl_name = 0 }
