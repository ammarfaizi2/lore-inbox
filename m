Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932680AbWF0EzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbWF0EzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030691AbWF0EyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:54:12 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:34267 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933406AbWF0EkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:24 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 4/4] [Suspend2] Power_off.c header.
Date: Tue, 27 Jun 2006 14:40:23 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044022.14736.76858.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044010.14736.18813.stgit@nigel.suspend2.net>
References: <20060627044010.14736.18813.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a declaration for the powerdown function and variable controlling the
method used.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/power_off.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/kernel/power/power_off.h b/kernel/power/power_off.h
new file mode 100644
index 0000000..921bfec
--- /dev/null
+++ b/kernel/power/power_off.h
@@ -0,0 +1,13 @@
+/*
+ * kernel/power/power_off.h
+ *
+ * Copyright (C) 2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Support for the powering down.
+ */
+
+int suspend_pm_state_finish(void);
+void suspend_power_down(void);
+extern unsigned long suspend_powerdown_method;

--
Nigel Cunningham		nigel at suspend2 dot net
