Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVCUPBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVCUPBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVCUO7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 09:59:34 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:7164 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261820AbVCUO6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 09:58:36 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050321143033.18167.58907.96506@clementine.local>
Subject: [PATCH] ttpci/budget: MODULE_PARM_DESC
Date: Mon, 21 Mar 2005 15:58:34 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove incorrect "budget_"-prefix from parameter description.
Error detected with section2text.rb, see autoparam patch. 

Signed-off-by: Magnus Damm <damm@opensource.se>

--- linux-2.6.12-rc1/drivers/media/dvb/ttpci/budget-core.c	2005-03-20 18:20:16.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/drivers/media/dvb/ttpci/budget-core.c	2005-03-21 14:28:01.000000000 +0100
@@ -41,7 +41,7 @@
 
 int budget_debug;
 module_param_named(debug, budget_debug, int, 0644);
-MODULE_PARM_DESC(budget_debug, "Turn on/off budget debugging (default:off).");
+MODULE_PARM_DESC(debug, "Turn on/off budget debugging (default:off).");
 
 /****************************************************************************
  * TT budget / WinTV Nova
