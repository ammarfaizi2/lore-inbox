Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbTCYBcM>; Mon, 24 Mar 2003 20:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbTCYBaW>; Mon, 24 Mar 2003 20:30:22 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:26128 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261340AbTCYB2J>;
	Mon, 24 Mar 2003 20:28:09 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.66
In-reply-to: <10485563243428@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Mar 2003 17:38 -0800
Message-id: <10485563242021@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.985.1.3, 2003/03/24 12:58:59-08:00, greg@kroah.com

[PATCH] i2c: fix typo that newer versions of gcc catch.


 drivers/i2c/scx200_acb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/scx200_acb.c b/drivers/i2c/scx200_acb.c
--- a/drivers/i2c/scx200_acb.c	Mon Mar 24 17:27:00 2003
+++ b/drivers/i2c/scx200_acb.c	Mon Mar 24 17:27:00 2003
@@ -140,7 +140,7 @@
 
 	switch (iface->state) {
 	case state_idle:
-		dev_warn(&iface->adapter.dev, "interrupt in idle state\n",);
+		dev_warn(&iface->adapter.dev, "interrupt in idle state\n");
 		break;
 
 	case state_address:

