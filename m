Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318944AbSIIWW6>; Mon, 9 Sep 2002 18:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318943AbSIIWVX>; Mon, 9 Sep 2002 18:21:23 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:16651 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318944AbSIIWTi>;
	Mon, 9 Sep 2002 18:19:38 -0400
Date: Mon, 9 Sep 2002 15:21:28 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.34
Message-ID: <20020909222128.GL7433@kroah.com>
References: <20020909221627.GE7433@kroah.com> <20020909221955.GG7433@kroah.com> <20020909222016.GH7433@kroah.com> <20020909222037.GI7433@kroah.com> <20020909222057.GJ7433@kroah.com> <20020909222112.GK7433@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020909222112.GK7433@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.629   -> 1.630  
#	 drivers/pci/probe.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	greg@kroah.com	1.630
# PCI: export pci_scan_bus() as the IBM PCI Hotplug driver needs it.
# --------------------------------------------
#
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Mon Sep  9 15:09:35 2002
+++ b/drivers/pci/probe.c	Mon Sep  9 15:09:35 2002
@@ -594,4 +594,5 @@
 EXPORT_SYMBOL(pci_add_new_bus);
 EXPORT_SYMBOL(pci_do_scan_bus);
 EXPORT_SYMBOL(pci_scan_slot);
+EXPORT_SYMBOL(pci_scan_bus);
 #endif
