Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWAUAgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWAUAgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWAUAgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:36:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17171 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932320AbWAUAgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:36:36 -0500
Date: Sat, 21 Jan 2006 01:36:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: yi.zhu@intel.com, jketreno@linux.intel.com
Cc: linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/wireless/ipw2100.c: make ipw2100_wpa_assoc_frame() static
Message-ID: <20060121003636.GK31803@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global ipw2100_wpa_assoc_frame() static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm2-full/drivers/net/wireless/ipw2100.c.old	2006-01-21 00:53:47.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/drivers/net/wireless/ipw2100.c	2006-01-21 00:53:59.000000000 +0100
@@ -5771,8 +5771,8 @@
 	return ret;
 }
 
-void ipw2100_wpa_assoc_frame(struct ipw2100_priv *priv,
-			     char *wpa_ie, int wpa_ie_len)
+static void ipw2100_wpa_assoc_frame(struct ipw2100_priv *priv,
+				    char *wpa_ie, int wpa_ie_len)
 {
 
 	struct ipw2100_wpa_assoc_frame frame;

