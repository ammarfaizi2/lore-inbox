Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319744AbSIMSas>; Fri, 13 Sep 2002 14:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319743AbSIMS3d>; Fri, 13 Sep 2002 14:29:33 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:2315 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319745AbSIMS2s>;
	Fri, 13 Sep 2002 14:28:48 -0400
Date: Fri, 13 Sep 2002 11:30:03 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI Hotplug changes for 2.4.20-pre7
Message-ID: <20020913183003.GE26589@kroah.com>
References: <20020913182846.GA26589@kroah.com> <20020913182903.GB26589@kroah.com> <20020913182930.GC26589@kroah.com> <20020913182945.GD26589@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020913182945.GD26589@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.663   -> 1.664  
#	   drivers/pci/pci.c	1.32    -> 1.33   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/13	greg@kroah.com	1.664
# [PATCH] export pci_scan_bus, as the IBM pci hotplug driver needs it.
# 
# --------------------------------------------
#
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Fri Sep 13 10:57:19 2002
+++ b/drivers/pci/pci.c	Fri Sep 13 10:57:19 2002
@@ -2153,6 +2153,7 @@
 EXPORT_SYMBOL(pci_add_new_bus);
 EXPORT_SYMBOL(pci_do_scan_bus);
 EXPORT_SYMBOL(pci_scan_slot);
+EXPORT_SYMBOL(pci_scan_bus);
 #ifdef CONFIG_PROC_FS
 EXPORT_SYMBOL(pci_proc_attach_device);
 EXPORT_SYMBOL(pci_proc_detach_device);
