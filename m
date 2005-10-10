Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVJJRFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVJJRFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVJJRFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:05:15 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:54149
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750955AbVJJRFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:05:14 -0400
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, jketreno@linux.intel.com, jgarzik@pobox.com
Subject: [PATCH] Documentation/networking/README.ipw2100
Date: Mon, 10 Oct 2005 13:05:11 -0400
Message-Id: <20051010165917.M60859@linuxwireless.org>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.126.157.6 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This updates the Documentation so that IPW2100 can be well documented for
2.6.14, the Kconfig points to this file but there is no information about the
firmware.

Please apply.

Signed-off-by: Alejandro Bonilla <abonilla@linuxwireless.org>


diff --git a/Documentation/networking/README.ipw2100
b/Documentation/networking/README.ipw2100
--- a/Documentation/networking/README.ipw2100
+++ b/Documentation/networking/README.ipw2100
@@ -143,7 +143,12 @@ firmware image to load into the wireless
 
 You can obtain these images from <http://ipw2100.sf.net/firmware.php>.
 
-See INSTALL for instructions on installing the firmware.
+The firmware package should be extracted where your hotplug firmware agent
+is looking:
+
+% grep FIRMWARE /etc/hotplug/firmware.agent
+
+The most common path is /lib/firmware but the firmware.agent will tell.
 
 
 ===========================

