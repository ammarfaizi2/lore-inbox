Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVIDXg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVIDXg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVIDXbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:31:01 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:30337 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932112AbVIDXaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:12 -0400
Message-Id: <20050904232320.156303000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:10 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dominique Dumont <domi.dumont@free.fr>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Content-Disposition: inline; filename=dvb-core-dvb-ca-en50221-timeout-fix.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 11/54] core: CI timeout fix
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Dumont <domi.dumont@free.fr>

Patch from Dominique Dumont to get the SCM Red Viaccess CAM working with the budget-ci.

Signed-off-by: Dominique Dumont <domi.dumont@free.fr>
Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-core/dvb_ca_en50221.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-09-04 22:24:24.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-09-04 22:28:00.000000000 +0200
@@ -47,7 +47,7 @@ MODULE_PARM_DESC(cam_debug, "enable verb
 
 #define dprintk if (dvb_ca_en50221_debug) printk
 
-#define INIT_TIMEOUT_SECS 5
+#define INIT_TIMEOUT_SECS 10
 
 #define HOST_LINK_BUF_SIZE 0x200
 

--

