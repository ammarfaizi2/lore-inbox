Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbVEHUT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbVEHUT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbVEHUTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:19:41 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:1175 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262932AbVEHTKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:10 -0400
Message-Id: <20050508184349.742640000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:43:03 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-bt8xx-dst-modparm.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 34/37] DST: fix a bug in the module parameter
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix a bug in the module parameter (Dominique Dumont)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/bt8xx/dst_ca.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_ca.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dst_ca.c	2005-05-08 18:13:54.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_ca.c	2005-05-08 18:14:03.000000000 +0200
@@ -38,7 +38,7 @@ MODULE_PARM_DESC(verbose, "verbose start
 
 static unsigned int debug = 1;
 module_param(debug, int, 0644);
-MODULE_PARM_DESC(dst_ca_debug, "debug messages, default is 0 (yes)");
+MODULE_PARM_DESC(debug, "debug messages, default is 1 (yes)");
 
 #define dprintk if (debug) printk
 

--

