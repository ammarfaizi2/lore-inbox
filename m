Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288173AbSAUUVW>; Mon, 21 Jan 2002 15:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288169AbSAUUVM>; Mon, 21 Jan 2002 15:21:12 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:55310 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288121AbSAUUVE>;
	Mon, 21 Jan 2002 15:21:04 -0500
Date: Mon, 21 Jan 2002 12:16:29 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI Hotplug documentation
Message-ID: <20020121201629.GA3720@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.5.3-pre2 that adds the pci_hotplug driver core
to the kernel documentation build process.

thanks,

greg k-h


diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	Mon Jan 21 10:48:39 2002
+++ b/Documentation/DocBook/Makefile	Mon Jan 21 10:48:39 2002
@@ -93,6 +93,8 @@
 		$(TOPDIR)/drivers/net/8390.c \
 		$(TOPDIR)/drivers/char/serial.c \
 		$(TOPDIR)/drivers/pci/pci.c \
+		$(TOPDIR)/drivers/hotplug/pci_hotplug_core.c \
+		$(TOPDIR)/drivers/hotplug/pci_hotplug_util.c \
 		$(TOPDIR)/drivers/block/ll_rw_blk.c \
 		$(TOPDIR)/drivers/sound/sound_core.c \
 		$(TOPDIR)/drivers/sound/sound_firmware.c \
diff -Nru a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
--- a/Documentation/DocBook/kernel-api.tmpl	Mon Jan 21 10:48:38 2002
+++ b/Documentation/DocBook/kernel-api.tmpl	Mon Jan 21 10:48:38 2002
@@ -162,6 +162,10 @@
      <sect1><title>PCI Support Library</title>
 !Edrivers/pci/pci.c
      </sect1>
+     <sect1><title>PCI Hotplug Support Library</title>
+!Edrivers/hotplug/pci_hotplug_core.c
+!Edrivers/hotplug/pci_hotplug_util.c
+     </sect1>
      <sect1><title>MCA Architecture</title>
 	<sect2><title>MCA Device Functions</title>
 !Earch/i386/kernel/mca.c

