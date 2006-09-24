Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWIXRMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWIXRMB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 13:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWIXRMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 13:12:01 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:55693 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751174AbWIXRMA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 13:12:00 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] Add "or later" clause to licence statement.
Date: Sun, 24 Sep 2006 19:11:50 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060924171149.22677.60248.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify my (Pierre's) position on which GPL versions apply. The patch
only touches the source files where I am the only major author. The
people who have made the minor commits to the files have been contacted
and have no issues with this change.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 arch/i386/kernel/i8237.c |    5 +++++
 drivers/mmc/sdhci.c      |    5 +++--
 drivers/mmc/sdhci.h      |    5 +++--
 drivers/mmc/wbsd.c       |    5 +++--
 drivers/mmc/wbsd.h       |    5 +++--
 5 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/i386/kernel/i8237.c b/arch/i386/kernel/i8237.c
index c36d1c0..6f508e8 100644
--- a/arch/i386/kernel/i8237.c
+++ b/arch/i386/kernel/i8237.c
@@ -2,6 +2,11 @@
  * i8237.c: 8237A DMA controller suspend functions.
  *
  * Written by Pierre Ossman, 2005.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
  */
 
 #include <linux/init.h>
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 4e21b3b..835dc1f 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -4,8 +4,9 @@
  *  Copyright (C) 2005-2006 Pierre Ossman, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/mmc/sdhci.h b/drivers/mmc/sdhci.h
index f245334..72a6793 100644
--- a/drivers/mmc/sdhci.h
+++ b/drivers/mmc/sdhci.h
@@ -4,8 +4,9 @@
  *  Copyright (C) 2005 Pierre Ossman, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
  */
 
 /*
diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
index c351c6d..eb67075 100644
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -4,8 +4,9 @@
  *  Copyright (C) 2004-2005 Pierre Ossman, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
  *
  *
  * Warning!
diff --git a/drivers/mmc/wbsd.h b/drivers/mmc/wbsd.h
index 249baa7..6072993 100644
--- a/drivers/mmc/wbsd.h
+++ b/drivers/mmc/wbsd.h
@@ -4,8 +4,9 @@
  *  Copyright (C) 2004-2005 Pierre Ossman, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
  */
 
 #define LOCK_CODE		0xAA

