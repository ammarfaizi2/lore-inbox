Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVCUNn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVCUNn5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 08:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVCUNn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 08:43:57 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:19929 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261805AbVCUNnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 08:43:37 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050321131537.17274.5052.61849@clementine.local>
Subject: [PATCH] edgeport: MODULE_PARM_DESC
Date: Mon, 21 Mar 2005 14:43:37 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "low_latency"/"debug" parameter description duplication/mixup.
Error detected with section2text.rb, see autoparam patch. 

Signed-off-by: Magnus Damm <damm@opensource.se>

--- linux-2.6.12-rc1/drivers/usb/serial/io_edgeport.c	2005-03-20 18:20:17.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/drivers/usb/serial/io_edgeport.c	2005-03-21 14:01:12.000000000 +0100
@@ -3110,4 +3110,4 @@
 MODULE_PARM_DESC(debug, "Debug enabled or not");
 
 module_param(low_latency, bool, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(debug, "Low latency enabled or not");
+MODULE_PARM_DESC(low_latency, "Low latency enabled or not");
