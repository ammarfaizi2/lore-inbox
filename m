Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933193AbWFZX1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933193AbWFZX1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933173AbWFZX1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:27:33 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:43935 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933124AbWFZWgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:04 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/19] [Suspend2] Core io.c header.
Date: Tue, 27 Jun 2006 08:36:01 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223559.4219.4716.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the header and #includes for kernel/power/io.c.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
new file mode 100644
index 0000000..df0ec8d
--- /dev/null
+++ b/kernel/power/io.c
@@ -0,0 +1,31 @@
+/*
+ * kernel/power/io.c
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains high level IO routines for suspending.
+ *
+ */
+
+#include <linux/suspend.h>
+#include <linux/version.h>
+#include <linux/utsname.h>
+#include <linux/mount.h>
+#include <linux/suspend2.h>
+
+#include "version.h"
+#include "modules.h"
+#include "pageflags.h"
+#include "io.h"
+#include "ui.h"
+#include "suspend2_common.h"
+#include "suspend2.h"
+#include "storage.h"
+#include "prepare_image.h"
+#include "extent.h"
+

--
Nigel Cunningham		nigel at suspend2 dot net
