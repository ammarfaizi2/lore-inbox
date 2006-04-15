Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWDOXBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWDOXBz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 19:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWDOXBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 19:01:55 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:39684 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932513AbWDOXBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 19:01:54 -0400
Date: Sun, 16 Apr 2006 01:01:53 +0200
From: Jean-Luc =?iso-8859-1?Q?L=E9ger?= 
	<jean-luc.leger@dspnet.fr.eu.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cleanup default value of DVB_CINERGYT2_ENABLE_RC_INPUT_DEVICE
Message-ID: <20060415230153.GH47644@dspnet.fr.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Default values for boolean and tristate options can only be 'y', 'm' or 'n'.
This patch updates default value for DVB_CINERGYT2_ENABLE_RC_INPUT_DEVICE.

Signed-off-by: Jean-Luc Léger <jean-luc.leger@dspnet.fr.eu.org>

Index: linux-2.6.17-rc1/drivers/media/dvb/cinergyT2/Kconfig
===================================================================
--- linux-2.6.17-rc1/drivers/media/dvb/cinergyT2/Kconfig.old    2006-04-15 22:14:43.000000000 +0200
+++ linux-2.6.17-rc1/drivers/media/dvb/cinergyT2/Kconfig        2006-04-15 22:16:02.000000000 +0200
@@ -64,7 +64,7 @@
 config DVB_CINERGYT2_ENABLE_RC_INPUT_DEVICE
 	bool "Register the onboard IR Remote Control Receiver as Input Device"
 	depends on DVB_CINERGYT2_TUNING
-	default "yes"
+	default y
 	help
 	  Enable this option if you want to use the onboard Infrared Remote
 	  Control Receiver as Linux-Input device.

