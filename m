Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288005AbSBIBY2>; Fri, 8 Feb 2002 20:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288021AbSBIBYS>; Fri, 8 Feb 2002 20:24:18 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:15374 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288005AbSBIBYH>;
	Fri, 8 Feb 2002 20:24:07 -0500
Date: Fri, 8 Feb 2002 17:21:02 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] pci hotplug fs name typo fix
Message-ID: <20020209012101.GA28101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 11 Jan 2002 23:16:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pull from:  http://linuxusb.bkbits.net/linus-2.5


ChangeSet@1.230, 2002-02-08 17:16:12-08:00, greg@soap.kroah.net
  typo fix for the name of the pci hotplug filesystem caused by the superblock changes.

 drivers/hotplug/pci_hotplug_core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
  

thanks,

greg k-h


diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Fri Feb  8 15:03:27 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Fri Feb  8 15:03:27 2002
@@ -396,7 +396,7 @@
 
 static struct file_system_type pcihpfs_type = {
 	owner:		THIS_MODULE,
-	name:		"pchihpfs",
+	name:		"pcihpfs",
 	get_sb:		pcihpfs_get_sb,
 	fs_flags:	FS_LITTER,
 };
