Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWF0FDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWF0FDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030658AbWF0Ejk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:39:40 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:25563 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030649AbWF0Ej2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:28 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/13] [Suspend2] Netlink.c header
Date: Tue, 27 Jun 2006 14:39:27 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043925.14630.14370.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043923.14630.565.stgit@nigel.suspend2.net>
References: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/power/netlink.c implements the interface between Suspend2 and
userspace helpers (the userui and storage manager).

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/netlink.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/kernel/power/netlink.c b/kernel/power/netlink.c
new file mode 100644
index 0000000..8d27801
--- /dev/null
+++ b/kernel/power/netlink.c
@@ -0,0 +1,17 @@
+/*
+ * kernel/power/netlink.c
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Functions for communicating with a userspace helper via netlink.
+ */
+
+
+#include <linux/suspend.h>
+#include "netlink.h"
+
+#ifdef CONFIG_NET
+struct user_helper_data *uhd_list = NULL;
+       

--
Nigel Cunningham		nigel at suspend2 dot net
