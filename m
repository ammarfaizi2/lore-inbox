Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWATTNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWATTNp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWATTN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:13:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:32720 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751165AbWATTFC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:02 -0500
Cc: pavel@ucw.cz
Subject: [PATCH] PCI Hotplug: fix up Kconfig help text
In-Reply-To: <11377838783611@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:39 -0800
Message-Id: <1137783879143@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug: fix up Kconfig help text

Remove reference to pcihpfs that no longer exists.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit d181278c96e0b59478bef909ec2476c40169e7ba
tree 0973a8ecbeffd44fb57343d771dbe493036a16e7
parent 4153374c18ee71fa8bdaa6a7e88ec42f8ec633f4
author Pavel Machek <pavel@ucw.cz> Mon, 09 Jan 2006 16:16:00 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:34 -0800

 drivers/pci/hotplug/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 2f1289e..222a1cc 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -11,8 +11,7 @@ config HOTPLUG_PCI
 	---help---
 	  Say Y here if you have a motherboard with a PCI Hotplug controller.
 	  This allows you to add and remove PCI cards while the machine is
-	  powered up and running.  The file system pcihpfs must be mounted
-	  in order to interact with any PCI Hotplug controllers.
+	  powered up and running.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called pci_hotplug.

