Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbUCPAEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbUCPAEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:04:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:6575 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262881AbUCPACC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:02 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913911614@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:31 -0800
Message-Id: <10793913913858@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.10, 2004/02/23 16:28:17-08:00, khali@linux-fr.org

[PATCH] I2C: Lowercase chips name

This patch brings the name field of adm1021.c, it87.c and via686a.c in
conformance with the defined standard ("all lowercase, as simple as the
driver name itself").


 drivers/i2c/chips/adm1021.c |    2 +-
 drivers/i2c/chips/it87.c    |    2 +-
 drivers/i2c/chips/via686a.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Mon Mar 15 14:37:09 2004
+++ b/drivers/i2c/chips/adm1021.c	Mon Mar 15 14:37:09 2004
@@ -148,7 +148,7 @@
 /* This is the driver that will be inserted */
 static struct i2c_driver adm1021_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "ADM1021-MAX1617",
+	.name		= "adm1021",
 	.id		= I2C_DRIVERID_ADM1021,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm1021_attach_adapter,
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Mon Mar 15 14:37:09 2004
+++ b/drivers/i2c/chips/it87.c	Mon Mar 15 14:37:09 2004
@@ -231,7 +231,7 @@
 
 static struct i2c_driver it87_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "IT87xx",
+	.name		= "it87",
 	.id		= I2C_DRIVERID_IT87,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= it87_attach_adapter,
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Mon Mar 15 14:37:09 2004
+++ b/drivers/i2c/chips/via686a.c	Mon Mar 15 14:37:09 2004
@@ -653,7 +653,7 @@
    smbus_driver and isa_driver, and clients could be of either kind */
 static struct i2c_driver via686a_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "VIA686A",
+	.name		= "via686a",
 	.id		= I2C_DRIVERID_VIA686A,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= via686a_attach_adapter,

