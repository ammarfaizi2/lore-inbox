Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVCCMSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVCCMSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVCCLG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:06:28 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:4532 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262526AbVCCKl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:41:59 -0500
Date: Thu, 3 Mar 2005 11:41:47 +0100
Message-Id: <200503031041.j23AflwD020710@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 5/16] DocBook: update function parameter description in USB code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: update function parameter description in USB code
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2029  -> 1.2030 
#	drivers/usb/core/hub.c	1.160   -> 1.161  
#	drivers/usb/core/hcd.c	1.115   -> 1.116  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/01/26	tali@admingilde.org	1.2030
# DocBook: update function parameter description in USB code
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	Thu Mar  3 11:41:51 2005
+++ b/drivers/usb/core/hcd.c	Thu Mar  3 11:41:51 2005
@@ -1394,7 +1394,7 @@
 /**
  * usb_bus_start_enum - start immediate enumeration (for OTG)
  * @bus: the bus (must use hcd framework)
- * @port: 1-based number of port; usually bus->otg_port
+ * @port_num: 1-based number of port; usually bus->otg_port
  * Context: in_interrupt()
  *
  * Starts enumeration, with an immediate reset followed later by
diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	Thu Mar  3 11:41:51 2005
+++ b/drivers/usb/core/hub.c	Thu Mar  3 11:41:51 2005
@@ -383,7 +383,7 @@
 
 /**
  * usb_hub_tt_clear_buffer - clear control/bulk TT state in high speed hub
- * @dev: the device whose split transaction failed
+ * @udev: the device whose split transaction failed
  * @pipe: identifies the endpoint of the failed transaction
  *
  * High speed HCDs use this to tell the hub driver that some split control or
