Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVEHUD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVEHUD6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbVEHUC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:02:29 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:2199 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262935AbVEHTKM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:12 -0400
Message-Id: <20050508184349.886682000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:43:04 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-bt8xx-dst-debug-print.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 35/37] DST: fixed CI debug output
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fixed CI debug output (Dominique Dumont)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/bt8xx/dst_ca.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_ca.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dst_ca.c	2005-05-08 18:14:03.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_ca.c	2005-05-08 18:14:08.000000000 +0200
@@ -162,7 +162,7 @@ static int ca_get_app_info(struct dst_st
 		dprintk("%s: ================================ CI Module Application Info ======================================\n", __FUNCTION__);
 		dprintk("%s: Application Type=[%d], Application Vendor=[%d], Vendor Code=[%d]\n%s: Application info=[%s]\n",
 			__FUNCTION__, state->messages[7], (state->messages[8] << 8) | state->messages[9],
-			(state->messages[10] << 8) | state->messages[11], __FUNCTION__, (char *)(&state->messages[11]));
+			(state->messages[10] << 8) | state->messages[11], __FUNCTION__, (char *)(&state->messages[12]));
 		dprintk("%s: ==================================================================================================\n", __FUNCTION__);
 	}
 

--

