Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265495AbTIDTB1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbTIDTB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:01:27 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:49040 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265495AbTIDTBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:01:25 -0400
Subject: [PATCH] 2.4.22 precedes 0.9.9 in module-init-tools of course
From: Pat LaVarre <p.lavarre@ieee.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1062702349.4977.15.camel@lintel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 04 Sep 2003 13:05:49 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Sep 2003 19:01:24.0928 (UTC) FILETIME=[EFFC7400:01C37316]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: linux-2.6.0-test4/Documentation/Changes
> o  module-init-tools      0.9.9                   # depmod -V

Newbie me, I was slow to imagine that depmod -V could be helpfully
reporting two independent series of version numbers, the older prefaced
with "depmod version ", the newer prefaced with "module-init-tools ".

I wrongly thought that 2.4.22 was 0.9.9 or better, even when I saw the
modprobe complaint:
QM_MODULES: Function not implemented

Therefore I propose the following patch.

Pat LaVarre

--- linux-2.6.0-test4/Documentation/Changes	2003-08-22 18:00:12.000000000 -0600
+++ linux/Documentation/Changes	2003-09-03 15:18:30.691529216 -0600
@@ -65,6 +65,9 @@
 o  procps                 2.0.9                   # ps --version
 o  oprofile               0.5.3                   # oprofiled --version
 
+Also upgrade your module-init-tools if your depmod -V gives you a
+"depmod version" rather than a "module-init-tools" version.
+
 Kernel compilation
 ==================
 



