Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVF0Nhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVF0Nhk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVF0Ne5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:34:57 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:29413 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262083AbVF0MQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:58 -0400
Message-Id: <20050627121410.954450000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:07 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq_dvb@lidskialf.net>
Content-Disposition: inline; filename=dvb-core-remove-i2c-ids.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 07/51] frontend: remove unused I2C ids
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Remove I2C_DRIVERID_DVBFE_ cruft.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-core/dvb_frontend.h |   22 ----------------------
 1 files changed, 22 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-core/dvb_frontend.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-core/dvb_frontend.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-core/dvb_frontend.h	2005-06-27 13:23:01.000000000 +0200
@@ -40,28 +40,6 @@
 
 #include "dvbdev.h"
 
-/* FIXME: Move to i2c-id.h */
-#define I2C_DRIVERID_DVBFE_SP8870	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_CX22700	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_AT76C651	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_CX24110	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_CX22702	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_DIB3000MB	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_DST		I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_DUMMY	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_L64781	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_MT312	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_MT352	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_NXT6000	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_SP887X	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_STV0299	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_TDA1004X	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_TDA8083	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_VES1820	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_VES1X93	I2C_DRIVERID_EXP2
-#define I2C_DRIVERID_DVBFE_TDA80XX	I2C_DRIVERID_EXP2
-
-
 struct dvb_frontend_tune_settings {
         int min_delay_ms;
         int step_size;

--

