Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269515AbUJTHGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269515AbUJTHGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269859AbUJSXI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:08:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:650 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270104AbUJSWqY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:24 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225737586@kroah.com>
Date: Tue, 19 Oct 2004 15:42:17 -0700
Message-Id: <1098225737284@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.45, 2004/10/06 13:18:01-07:00, buytenh@wantstofly.org

[PATCH] PCI: minor pci.ids update

Here is another patch (against 2.6.9-rc2, not sure if that has the
latest version of the PCI db) that removes the vendor names from Intel
IXP and Radisys ENP entries, as per Martin's suggestion.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.ids |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	2004-10-19 15:23:35 -07:00
+++ b/drivers/pci/pci.ids	2004-10-19 15:23:35 -07:00
@@ -8429,9 +8429,9 @@
 	84e6  460GX - 82466GX Wide and fast PCI eXpander Bridge (WXB)
 	84ea  460GX - 84460GX AGP Bridge (GXB function 1)
 	8500  IXP4xx Family  Network Processor (IXP420, 421, 422, 425 and IXC1100)
-	9000  Intel IXP2000 Family Network Processor
-	9001  Intel IXP2400 Network Processor
-	9004  Intel IXP2800 Network Processor
+	9000  IXP2000 Family Network Processor
+	9001  IXP2400 Network Processor
+	9004  IXP2800 Network Processor
 	9621  Integrated RAID
 	9622  Integrated RAID
 	9641  Integrated RAID
@@ -8440,7 +8440,7 @@
 # observed, and documented in Intel revision note; new mask of 1011:0026
 	b154  21154 PCI-to-PCI Bridge
 	b555  21555 Non transparent PCI-to-PCI Bridge
-		1331 0030  Radisys ENP-2611
+		1331 0030  ENP-2611
 		4c53 1050  CT7 mainboard
 		4c53 1051  CE7 mainboard
 		e4bf 1000  CC8-1-BLUES

