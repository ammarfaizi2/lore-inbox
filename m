Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVAHHgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVAHHgK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVAHHem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:34:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:50053 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261877AbVAHFsU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:20 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632613305@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:42 -0800
Message-Id: <11051632622393@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.23, 2004/12/21 10:50:37-08:00, ecashin@coraid.com

[PATCH] rename ETH_P_AOE

Rename old ETH_P_EDP2 ("EtherDrive Protocol 2") to ETH_P_AOE (ATA over
Ethernet).

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/block/aoe/aoe.h  |    1 -
 include/linux/if_ether.h |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h	2005-01-07 15:41:09 -08:00
+++ b/drivers/block/aoe/aoe.h	2005-01-07 15:41:09 -08:00
@@ -26,7 +26,6 @@
 	AOECCMD_FSET,
 
 	AOE_HVER = 0x10,
-	ETH_P_AOE = 0x88a2,
 };
 
 struct aoe_hdr {
diff -Nru a/include/linux/if_ether.h b/include/linux/if_ether.h
--- a/include/linux/if_ether.h	2005-01-07 15:41:09 -08:00
+++ b/include/linux/if_ether.h	2005-01-07 15:41:09 -08:00
@@ -69,7 +69,7 @@
 #define ETH_P_ATMFATE	0x8884		/* Frame-based ATM Transport
 					 * over Ethernet
 					 */
-#define ETH_P_EDP2	0x88A2		/* Coraid EDP2			*/
+#define ETH_P_AOE	0x88A2		/* ATA over Ethernet		*/
 
 /*
  *	Non DIX types. Won't clash for 1500 types.

