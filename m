Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbTBYBPg>; Mon, 24 Feb 2003 20:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbTBYBOL>; Mon, 24 Feb 2003 20:14:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:53007 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264610AbTBYBNo>;
	Mon, 24 Feb 2003 20:13:44 -0500
Subject: Re: [PATCH] PCI hotplug changes for 2.5.63
In-reply-to: <10461357531947@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Feb 2003 17:15 -0800
Message-id: <10461357562562@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1022.1.2, 2003/02/24 16:25:28-08:00, greg@kroah.com

[PATCH] IBM PCI Hotplug: fix typo in previous patch.


diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Mon Feb 24 17:15:59 2003
+++ b/drivers/hotplug/ibmphp_core.c	Mon Feb 24 17:15:59 2003
@@ -1584,7 +1584,7 @@
 	bus = ibmphp_find_bus (0);
 	if (!bus) {
 		err ("Can't find the root pci bus, can not continue\n");
-		rc -ENODEV;
+		rc = -ENODEV;
 		goto error;
 	}
 	memcpy (ibmphp_pci_bus, bus, sizeof (*ibmphp_pci_bus));

