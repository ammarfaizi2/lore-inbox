Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbTCTW0C>; Thu, 20 Mar 2003 17:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262695AbTCTWZL>; Thu, 20 Mar 2003 17:25:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:43525 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262708AbTCTWVk>;
	Thu, 20 Mar 2003 17:21:40 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <1048199573405@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <1048199574195@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.14, 2003/03/20 11:28:11-08:00, greg@kroah.com

i2c i2c-amd8111.c: change the pci driver name to have "2" in it based on previous comments.


 drivers/i2c/busses/i2c-amd8111.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Thu Mar 20 12:53:26 2003
+++ b/drivers/i2c/busses/i2c-amd8111.c	Thu Mar 20 12:53:26 2003
@@ -392,7 +392,7 @@
 }
 
 static struct pci_driver amd8111_driver = {
-	.name		= "amd8111 smbus",
+	.name		= "amd8111 smbus 2",
 	.id_table	= amd8111_ids,
 	.probe		= amd8111_probe,
 	.remove		= __devexit_p(amd8111_remove),

