Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbTFRSLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 14:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbTFRSLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 14:11:43 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:28122 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265390AbTFRSLl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 14:11:41 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10559607081420@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.72
In-Reply-To: <10559607081639@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 18 Jun 2003 11:25:08 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1318.3.5, 2003/06/16 11:32:48-07:00, greg@kroah.com

[PATCH] I2C: add lm78 chip to Makefile


 drivers/i2c/chips/Makefile |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	Wed Jun 18 11:19:30 2003
+++ b/drivers/i2c/chips/Makefile	Wed Jun 18 11:19:30 2003
@@ -5,6 +5,7 @@
 obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
+obj-$(CONFIG_SENSORS_LM78)	+= lm78.o
 obj-$(CONFIG_SENSORS_LM85)	+= lm85.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o

