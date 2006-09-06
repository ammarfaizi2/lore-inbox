Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWIFQL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWIFQL5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWIFQL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:11:57 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:15371 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1751384AbWIFQL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:11:56 -0400
Subject: Re: [patch 6/6] process filtering for fault-injection capabilities
	[bug fix]
From: Don Mullis <dwm@meer.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 09:07:28 -0700
Message-Id: <1157558848.9460.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Type agreement in sscanf().

Signed-off-by: Don Mullis <dwm@meer.net>

---
 lib/should_fail.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17/lib/should_fail.c
===================================================================
--- linux-2.6.17.orig/lib/should_fail.c
+++ linux-2.6.17/lib/should_fail.c
@@ -16,7 +16,7 @@ int setup_should_fail(struct should_fail
 	unsigned long filter;
 
 	/* "<probability>,<interval>,<times>,<space>,<process-filter>" */
-	if (sscanf(str, "%lu,%lu,%d,%d,%d", &probability, &interval, &times,
+	if (sscanf(str, "%lu,%lu,%d,%d,%lu", &probability, &interval, &times,
 		   &space, &filter) < 5)
 		return 0;
 


