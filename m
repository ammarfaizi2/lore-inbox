Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVDLOcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVDLOcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVDLLE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:04:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:31946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262261AbVDLKdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:15 -0400
Message-Id: <200504121033.j3CAX8NF005789@shell0.pdx.osdl.net>
Subject: [patch 158/198] IB: remove unneeded includes
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, halr@voltaire.com,
       roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hal Rosenstock <halr@voltaire.com>

Eliminate no longer needed include files

Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/core/mad.c |    3 ---
 1 files changed, 3 deletions(-)

diff -puN drivers/infiniband/core/mad.c~ib-remove-unneeded-includes drivers/infiniband/core/mad.c
--- 25/drivers/infiniband/core/mad.c~ib-remove-unneeded-includes	2005-04-12 03:21:41.335852896 -0700
+++ 25-akpm/drivers/infiniband/core/mad.c	2005-04-12 03:21:41.339852288 -0700
@@ -33,9 +33,6 @@
  */
 
 #include <linux/dma-mapping.h>
-#include <linux/interrupt.h>
-
-#include <ib_mad.h>
 
 #include "mad_priv.h"
 #include "smi.h"
_
