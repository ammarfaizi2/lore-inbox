Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263757AbTDGWv4 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263768AbTDGWv4 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:51:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41600
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263757AbTDGWuf (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:50:35 -0400
Date: Tue, 8 Apr 2003 01:09:30 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080009.h3809Ume008955@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: compatmac not needed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/x86_64/kernel/suspend.c linux-2.5.67-ac1/arch/x86_64/kernel/suspend.c
--- linux-2.5.67/arch/x86_64/kernel/suspend.c	2003-04-08 00:37:34.000000000 +0100
+++ linux-2.5.67-ac1/arch/x86_64/kernel/suspend.c	2003-04-08 00:43:39.000000000 +0100
@@ -16,7 +16,6 @@
 #include <linux/poll.h>
 #include <linux/delay.h>
 #include <linux/sysrq.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include <linux/irq.h>
 #include <linux/pm.h>
