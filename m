Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbTBYBRx>; Mon, 24 Feb 2003 20:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbTBYBQL>; Mon, 24 Feb 2003 20:16:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:1808 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264950AbTBYBOD>;
	Mon, 24 Feb 2003 20:14:03 -0500
Subject: Re: [PATCH] PCI hotplug changes for 2.5.63
In-reply-to: <10461357803594@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Feb 2003 17:16 -0800
Message-id: <1046135780408@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1022.1.13, 2003/02/24 16:33:09-08:00, greg@kroah.com

[PATCH] PCI: export pci_scan_bus_parented which is needed by the IBM pci hotplug driver.


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Mon Feb 24 17:15:10 2003
+++ b/drivers/pci/probe.c	Mon Feb 24 17:15:10 2003
@@ -609,6 +609,7 @@
 	}
 	return b;
 }
+EXPORT_SYMBOL(pci_scan_bus_parented);
 
 EXPORT_SYMBOL(pci_devices);
 EXPORT_SYMBOL(pci_root_buses);

