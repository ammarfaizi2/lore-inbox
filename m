Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbTDHAIB (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263791AbTDHAHy (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 20:07:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25473
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263847AbTDGXZX (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:25:23 -0400
Date: Tue, 8 Apr 2003 01:44:13 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080044.h380iDD6009366@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH suspend doesnt need compatmac either
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/i386/kernel/suspend.c linux-2.5.67-ac1/arch/i386/kernel/suspend.c
--- linux-2.5.67/arch/i386/kernel/suspend.c	2003-03-06 17:04:22.000000000 +0000
+++ linux-2.5.67-ac1/arch/i386/kernel/suspend.c	2003-04-04 00:03:46.000000000 +0100
@@ -16,7 +16,6 @@
 #include <linux/poll.h>
 #include <linux/delay.h>
 #include <linux/sysrq.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include <linux/irq.h>
 #include <linux/pm.h>
