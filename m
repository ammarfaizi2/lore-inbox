Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUHWSz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUHWSz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUHWSyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:54:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:16068 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267330AbUHWShL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:11 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860893645@kroah.com>
Date: Mon, 23 Aug 2004 11:34:50 -0700
Message-Id: <1093286090887@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.47, 2004/08/10 16:31:14-07:00, dsaxena@plexity.net

[PATCH] Remove spaces from Skystar2 pci_driver.name field

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/media/dvb/b2c2/skystar2.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/media/dvb/b2c2/skystar2.c b/drivers/media/dvb/b2c2/skystar2.c
--- a/drivers/media/dvb/b2c2/skystar2.c	2004-08-23 11:02:10 -07:00
+++ b/drivers/media/dvb/b2c2/skystar2.c	2004-08-23 11:02:10 -07:00
@@ -2345,7 +2345,7 @@
 MODULE_DEVICE_TABLE(pci, skystar2_pci_tbl);
 
 static struct pci_driver skystar2_pci_driver = {
-	.name = "Technisat SkyStar2 driver",
+	.name = "SkyStar2",
 	.id_table = skystar2_pci_tbl,
 	.probe = skystar2_probe,
 	.remove = skystar2_remove,

