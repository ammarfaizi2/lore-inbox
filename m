Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVIDXtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVIDXtT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVIDXtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:49:18 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:42881 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932116AbVIDXai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:38 -0400
Message-Id: <20050904232335.315889000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:48 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttpci-av7110-disable-handshake.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 49/54] av7110: disable superflous firmware handshake
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disable superflous firmware handshake.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/av7110_hw.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/av7110_hw.c	2005-09-04 22:03:40.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/av7110_hw.c	2005-09-04 22:30:58.000000000 +0200
@@ -41,6 +41,8 @@
 #include "av7110.h"
 #include "av7110_hw.h"
 
+#define _NOHANDSHAKE
+
 /****************************************************************************
  * DEBI functions
  ****************************************************************************/

--

