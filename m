Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVCUM6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVCUM6f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 07:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVCUM6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 07:58:35 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:6602 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261766AbVCUM6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 07:58:32 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050321123030.15675.29090.94556@clementine.local>
Subject: [PATCH] bt878: MODULE_PARM_DESC
Date: Mon, 21 Mar 2005 13:58:30 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove incorrect "bt878_"-prefix from parameter description.
Error detected with section2text.rb, see autoparam patch. 

Signed-off-by: Magnus Damm <damm@opensource.se>

--- linux-2.6.12-rc1/drivers/media/dvb/bt8xx/bt878.c	2004-12-24 22:34:49.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/drivers/media/dvb/bt8xx/bt878.c	2005-03-21 13:16:32.000000000 +0100
@@ -55,10 +55,10 @@
 static unsigned int bt878_debug;
 
 module_param_named(verbose, bt878_verbose, int, 0444);
-MODULE_PARM_DESC(bt878_verbose,
+MODULE_PARM_DESC(verbose,
 		 "verbose startup messages, default is 1 (yes)");
 module_param_named(debug, bt878_debug, int, 0644);
-MODULE_PARM_DESC(bt878_debug, "Turn on/off debugging (default:off).");
+MODULE_PARM_DESC(debug, "Turn on/off debugging (default:off).");
 
 int bt878_num;
 struct bt878 bt878[BT878_MAX];
