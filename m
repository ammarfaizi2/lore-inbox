Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUDNW3D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUDNW1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:27:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:41119 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261952AbUDNWZA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:00 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814511233@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:11 -0700
Message-Id: <10819814513668@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.17, 2004/04/08 14:12:22-07:00, mochel@digitalimplant.org

[PATCH] I2C: class fixup for the ali1563 driver


 drivers/i2c/busses/i2c-ali1563.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	Wed Apr 14 15:13:33 2004
+++ b/drivers/i2c/busses/i2c-ali1563.c	Wed Apr 14 15:13:33 2004
@@ -357,6 +357,7 @@
 
 static struct i2c_adapter ali1563_adapter = {
 	.owner	= THIS_MODULE,
+	.class	= I2C_ADAP_CLASS_SMBUS,
 	.algo	= &ali1563_algorithm,
 };
 

