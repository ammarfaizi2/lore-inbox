Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUKTMhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUKTMhj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 07:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbUKTMhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 07:37:39 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:18956 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262744AbUKTMhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 07:37:35 -0500
Date: Sat, 20 Nov 2004 13:37:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] I2C updates for 2.4.28 (4/5)
Message-Id: <20041120133730.7bce8458.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two defined constants in include/linux/i2c.h aren't used anywhere,
haven't ever been and won't ever be. They simply don't correspond to
anything in the i2c core. Let's get rid of them.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.4.28-rc1/include/linux/i2c.h.orig	2004-10-27 23:45:50.000000000 +0200
+++ linux-2.4.28-rc1/include/linux/i2c.h	2004-10-29 19:28:38.000000000 +0200
@@ -47,11 +47,9 @@
 
 /* --- General options ------------------------------------------------	*/
 
-#define I2C_ALGO_MAX	4		/* control memory consumption	*/
-#define I2C_ADAP_MAX	16
+#define I2C_ADAP_MAX	16		/* control memory consumption	*/
 #define I2C_DRIVER_MAX	16
 #define I2C_CLIENT_MAX	32
-#define I2C_DUMMY_MAX 4
 
 struct i2c_algorithm;
 struct i2c_adapter;


-- 
Jean Delvare
http://khali.linux-fr.org/
