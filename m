Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWELXpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWELXpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWELXot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:49 -0400
Received: from mx.pathscale.com ([64.160.42.68]:60329 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932275AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 33 of 53] ipath - clean up some comments
X-Mercurial-Node: 5ddaf7c07cdf82fedd4d3fb29b3306705f607b9f
Message-Id: <5ddaf7c07cdf82fedd4d.1147477398@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:18 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r b9fd1a46c910 -r 5ddaf7c07cdf drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri May 12 15:55:28 2006 -0700
@@ -720,13 +720,8 @@ u64 ipath_read_kreg64_port(const struct 
  * @port: port number
  *
  * Return the contents of a register that is virtualized to be per port.
- * Prints a debug message and returns -1 on errors (not distinguishable from
- * valid contents at runtime; we may add a separate error variable at some
- * point).
- *
- * This is normally not used by the kernel, but may be for debugging, and
- * has a different implementation than user mode, which is why it's not in
- * _common.h.
+ * Returns -1 on errors (not distinguishable from valid contents at
+ * runtime; we may add a separate error variable at some point).
  */
 static inline u32 ipath_read_ureg32(const struct ipath_devdata *dd,
 				    ipath_ureg regno, int port)
