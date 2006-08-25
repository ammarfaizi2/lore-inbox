Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422793AbWHYS3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422793AbWHYS3n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbWHYS3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:29:23 -0400
Received: from mx.pathscale.com ([64.160.42.68]:42626 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422751AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 10 of 23] IB/ipath - trivial cleanups
X-Mercurial-Node: e1d26a79aee3dceb962888f939d6fd5026af774a
Message-Id: <e1d26a79aee3dceb9628.1156530275@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:35 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
@@ -528,7 +528,6 @@ void ipath_cdev_cleanup(struct cdev **cd
 
 int ipath_diag_add(struct ipath_devdata *);
 void ipath_diag_remove(struct ipath_devdata *);
-void ipath_diag_bringup_link(struct ipath_devdata *);
 
 extern wait_queue_head_t ipath_state_wait;
 
