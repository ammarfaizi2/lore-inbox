Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVDASvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVDASvb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbVDAS0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:26:44 -0500
Received: from webmail.topspin.com ([12.162.17.3]:34971 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262843AbVDASY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:24:57 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][2/6] IB: remove unneeded includes
In-Reply-To: <2005411023.BIKgS4OLfFzZN9qI@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 10:23:50 -0800
Message-Id: <2005411023.AERMWYHGiX8V5KDM@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 18:23:51.0160 (UTC) FILETIME=[F428FF80:01C536E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hal Rosenstock <halr@voltaire.com>

Eliminate no longer needed include files

Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/core/mad.c	2005-04-01 10:08:54.939957801 -0800
+++ linux-export/drivers/infiniband/core/mad.c	2005-04-01 10:08:56.473624910 -0800
@@ -33,9 +33,6 @@
  */
 
 #include <linux/dma-mapping.h>
-#include <linux/interrupt.h>
-
-#include <ib_mad.h>
 
 #include "mad_priv.h"
 #include "smi.h"

