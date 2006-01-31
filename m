Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWAaQL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWAaQL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWAaQL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:11:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62218 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751084AbWAaQL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:11:28 -0500
Date: Tue, 31 Jan 2006 17:11:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linville@tuxdriver.com
Cc: netdev@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org, yi.zhu@intel.com,
       jketreno@linux.intel.com
Subject: [2.6 patch] wrong firmware location in IPW2100 Kconfig entry
Message-ID: <20060131161124.GA3986@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>

Firmware should go into /lib/firmware, not /etc/firmware.

Found by Alejandro Bonilla.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Jesper Juhl on:
- 6 Sep 2005

--- linux-2.6.13-mm1-orig/drivers/net/wireless/Kconfig	2005-09-02 23:59:51.000000000 +0200
+++ linux-2.6.13-mm1/drivers/net/wireless/Kconfig	2005-09-06 20:39:45.000000000 +0200
@@ -152,7 +152,7 @@
 	  In order to use this driver, you will need a firmware image for it.
           You can obtain the firmware from
 	  <http://ipw2100.sf.net/>.  Once you have the firmware image, you 
-	  will need to place it in /etc/firmware.
+	  will need to place it in /lib/firmware.
 
           You will also very likely need the Wireless Tools in order to
           configure your card:


