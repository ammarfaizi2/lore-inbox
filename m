Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263753AbTDGX1y (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbTDGX1Y (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:27:24 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13697
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263753AbTDGXSy (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:18:54 -0400
Date: Tue, 8 Apr 2003 01:37:48 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080037.h380bmbu009270@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: wireless uses __init
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/net/core/wireless.c linux-2.5.67-ac1/net/core/wireless.c
--- linux-2.5.67/net/core/wireless.c	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.67-ac1/net/core/wireless.c	2003-04-03 23:44:27.000000000 +0100
@@ -54,6 +54,7 @@
 #include <linux/rtnetlink.h>		/* rtnetlink stuff */
 #include <linux/seq_file.h>
 #include <linux/wireless.h>		/* Pretty obvious */
+#include <linux/init.h>			/* for __init */
 
 #include <net/iw_handler.h>		/* New driver API */
 
