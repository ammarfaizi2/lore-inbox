Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbUKIFrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUKIFrf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUKIFrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:47:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:59294 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261380AbUKIFY5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:24:57 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778563547@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:16 -0800
Message-Id: <10999778564020@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.12, 2004/11/05 13:47:25-08:00, greg@kroah.com

I2C: fix MODULE_PARAM warning in pc87360.c driver

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/pc87360.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/pc87360.c b/drivers/i2c/chips/pc87360.c
--- a/drivers/i2c/chips/pc87360.c	2004-11-08 18:55:27 -08:00
+++ b/drivers/i2c/chips/pc87360.c	2004-11-08 18:55:27 -08:00
@@ -65,7 +65,7 @@
 };
 
 static int init = 1;
-MODULE_PARM(init, "i");
+module_param(init, int, 0);
 MODULE_PARM_DESC(init,
  "Chip initialization level:\n"
  " 0: None\n"

