Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVCTSeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVCTSeB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 13:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVCTSeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 13:34:00 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:40680 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261244AbVCTSd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 13:33:59 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050320180609.4062.24543.43709@clementine.local>
Subject: [PATCH] drm: MODULE_PARM_DESC
Date: Sun, 20 Mar 2005 19:33:58 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For 2.6.12 and 2.6.11.x:

Remove incorrect "drm_"-prefix from parameter description.

Signed-off-by: Magnus Damm <damm@opensource.se>

--- linux-2.6.11.5/drivers/char/drm/drm_stub.c	2005-03-20 18:09:14.348412000 +0100
+++ linux-2.6.11.5-drm_parm_desc/drivers/char/drm/drm_stub.c	2005-03-20 18:52:14.279203192 +0100
@@ -43,8 +43,8 @@
 MODULE_AUTHOR( DRIVER_AUTHOR );
 MODULE_DESCRIPTION( DRIVER_DESC );
 MODULE_LICENSE("GPL and additional rights");
-MODULE_PARM_DESC(drm_cards_limit, "Maximum number of graphics cards");
-MODULE_PARM_DESC(drm_debug, "Enable debug output");
+MODULE_PARM_DESC(cards_limit, "Maximum number of graphics cards");
+MODULE_PARM_DESC(debug, "Enable debug output");
 
 module_param_named(cards_limit, drm_cards_limit, int, 0444);
 module_param_named(debug, drm_debug, int, 0666);
