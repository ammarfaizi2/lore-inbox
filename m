Return-Path: <linux-kernel-owner+w=401wt.eu-S1754695AbXABAfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbXABAfn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 19:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700AbXABAfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 19:35:43 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:37524 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695AbXABAfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 19:35:43 -0500
Subject: [PATCH] Fix freezer.h mistake.
From: Nigel Cunningham <nigel@nigel.suspend2.net>
Reply-To: nigel@nigel.suspend2.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070101135718.GA19125@aepfle.de>
References: <1161519286.3512.12.camel@nigel.suspend2.net>
	 <20070101135718.GA19125@aepfle.de>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 09:38:51 +1100
Message-Id: <1167691131.5479.17.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no idea now why this fragment was in the patch, and Olaf has
rightly questioned it.

Please apply.

Regards,

Nigel

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index c8558d4..e63ea1c 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -42,7 +42,7 @@ #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/sysdev.h>
-#include <linux/freezer.h>
+#include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/cpu.h>
 #include <asm/prom.h>


