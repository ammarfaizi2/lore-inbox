Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423345AbWF1OMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423345AbWF1OMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423349AbWF1OMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:12:32 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:30491 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423346AbWF1OMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:12:32 -0400
Date: Wed, 28 Jun 2006 16:12:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, geraldsc@de.ibm.com
Subject: [patch] s390: avenrun export in appdata_base.c
Message-ID: <20060628141242.GA14375@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

[S390] avenrun export in appdata_base.c

Remove EXPORT_SYMBOL_GPL(avenrun) from appdata_base.c, since it is
already exported in kernel/timer.c

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata_base.c |    1 -
 1 files changed, 1 deletion(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2006-06-28 14:43:44.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2006-06-28 14:43:47.000000000 +0200
@@ -766,7 +766,6 @@ unsigned long nr_iowait(void)
 #endif /* MODULE */
 EXPORT_SYMBOL_GPL(si_swapinfo);
 EXPORT_SYMBOL_GPL(nr_threads);
-EXPORT_SYMBOL_GPL(avenrun);
 EXPORT_SYMBOL_GPL(get_full_page_state);
 EXPORT_SYMBOL_GPL(nr_running);
 EXPORT_SYMBOL_GPL(nr_iowait);
