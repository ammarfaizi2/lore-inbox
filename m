Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbVKRRqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbVKRRqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbVKRRqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:46:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:47594 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161013AbVKRRqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:46:48 -0500
Date: Fri, 18 Nov 2005 09:31:06 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, scjody@steamballoon.com
Subject: [patch 1/3] Add SCM info to MAINTAINERS
Message-ID: <20051118173106.GB20860@kroah.com>
References: <20051118173930.270902000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="add-scm-info-to-maintainers.patch"
In-Reply-To: <20051118173054.GA20860@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jody McIntyre <scjody@steamballoon.com>

Add tree information to MAINTAINERS file.

Signed-off-by: Jody McIntyre <scjody@steamballoon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 MAINTAINERS |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- usb-2.6.orig/MAINTAINERS
+++ usb-2.6/MAINTAINERS
@@ -58,6 +58,7 @@ P: Person
 M: Mail patches to
 L: Mailing list that is relevant to this area
 W: Web-page with status/info
+T: SCM tree type and URL.  Type is one of: git, hg, quilt.
 S: Status, one of the following:
 
 	Supported:	Someone is actually paid to look after this.
@@ -183,6 +184,7 @@ P:	Len Brown
 M:	len.brown@intel.com
 L:	acpi-devel@lists.sourceforge.net
 W:	http://acpi.sourceforge.net/
+T:	git kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
 S:	Maintained
 
 AD1816 SOUND DRIVER
@@ -418,6 +420,7 @@ BLOCK LAYER
 P:	Jens Axboe
 M:	axboe@suse.de
 L:	linux-kernel@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git
 S:	Maintained
 
 BLUETOOTH SUBSYSTEM
@@ -803,12 +806,14 @@ DRIVER CORE, KOBJECTS, AND SYSFS
 P:	Greg Kroah-Hartman
 M:	gregkh@suse.de
 L:	linux-kernel@vger.kernel.org
+T:	quilt kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
 S:	Supported
 
 DRM DRIVERS
 P:	David Airlie
 M:	airlied@linux.ie
 L:	dri-devel@lists.sourceforge.net
+T:	git kernel.org:/pub/scm/linux/kernel/git/airlied/drm-2.6.git
 S:	Maintained
 
 DSCC4 DRIVER
@@ -1113,6 +1118,7 @@ P:	Jean Delvare
 M:	khali@linux-fr.org
 L:	lm-sensors@lm-sensors.org
 W:	http://www.lm-sensors.nu/
+T:	quilt kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
 S:	Maintained
 
 I2O
@@ -1145,6 +1151,7 @@ P:	Tony Luck
 M:	tony.luck@intel.com
 L:	linux-ia64@vger.kernel.org
 W:	http://www.ia64-linux.org/
+T:	git kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
 S:	Maintained
 
 SN-IA64 (Itanium) SUB-PLATFORM
@@ -1212,6 +1219,7 @@ P:	Jody McIntyre
 M:	scjody@steamballoon.com
 L:	linux1394-devel@lists.sourceforge.net
 W:	http://www.linux1394.org/
+T:	git kernel.org:/pub/scm/linux/kernel/git/scjody/ieee1394.git
 S:	Maintained
 
 IEEE 1394 OHCI DRIVER
@@ -1263,6 +1271,7 @@ P:	Hal Rosenstock
 M:	halr@voltaire.com
 L:	openib-general@openib.org
 W:	http://www.openib.org/
+T:	git kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git
 S:	Supported
 
 INPUT (KEYBOARD, MOUSE, JOYSTICK) DRIVERS
@@ -1436,6 +1445,7 @@ P:	Kai Germaschewski
 M:	kai@germaschewski.name
 P:	Sam Ravnborg
 M:	sam@ravnborg.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/sam/kbuild.git
 S:	Maintained 
 
 KERNEL JANITORS
@@ -1782,6 +1792,7 @@ M:	akpm@osdl.org
 P:	Jeff Garzik
 M:	jgarzik@pobox.com
 L:	netdev@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
 S:	Maintained
 
 NETWORKING [GENERAL]
@@ -1959,6 +1970,7 @@ P:	Greg Kroah-Hartman
 M:	gregkh@suse.de
 L:	linux-kernel@vger.kernel.org
 L:	linux-pci@atrey.karlin.mff.cuni.cz
+T:	quilt kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
 S:	Supported
 
 PCI HOTPLUG CORE
@@ -1980,6 +1992,7 @@ S:	Maintained
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	http://lists.infradead.org/mailman/listinfo/linux-pcmcia
+T:	git kernel.org:/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git
 S:	Maintained
 
 PCNET32 NETWORK DRIVER
@@ -2189,6 +2202,7 @@ SCSI SUBSYSTEM
 P:	James E.J. Bottomley
 M:	James.Bottomley@SteelEye.com
 L:	linux-scsi@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git
 S:	Maintained
 
 SCSI TAPE DRIVER
@@ -2228,6 +2242,7 @@ SERIAL ATA (SATA) SUBSYSTEM:
 P:	Jeff Garzik
 M:	jgarzik@pobox.com
 L:	linux-ide@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
 S:	Supported
 
 SGI SN-IA64 (Altix) SERIAL CONSOLE DRIVER
@@ -2749,6 +2764,7 @@ M:	gregkh@suse.de
 L:	linux-usb-users@lists.sourceforge.net
 L:	linux-usb-devel@lists.sourceforge.net
 W:	http://www.linux-usb.org
+T:	quilt kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
 S:	Supported
 
 USB UHCI DRIVER

--
