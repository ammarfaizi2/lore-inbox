Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264657AbUENX4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264657AbUENX4B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUENXxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:53:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:24805 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264305AbUENX36 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:29:58 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <10845773571402@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:17 -0700
Message-Id: <1084577357292@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.7, 2004/05/05 15:33:39-07:00, khali@linux-fr.org

[PATCH] I2C: Sensors (W83627HF) in Tyan S2882


 drivers/i2c/chips/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Fri May 14 16:20:40 2004
+++ b/drivers/i2c/chips/Kconfig	Fri May 14 16:20:40 2004
@@ -163,7 +163,7 @@
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the Winbond W8378x series
-	  of sensor chips: the W83781D, W83782D, W83783S and W83682HF,
+	  of sensor chips: the W83781D, W83782D, W83783S and W83627HF,
 	  and the similar Asus AS99127F.
 	  
 	  This driver can also be built as a module.  If so, the module

