Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSJIWmu>; Wed, 9 Oct 2002 18:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbSJIWlg>; Wed, 9 Oct 2002 18:41:36 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:1804 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262448AbSJIWkS>;
	Wed, 9 Oct 2002 18:40:18 -0400
Date: Wed, 9 Oct 2002 15:42:01 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI hotplug changes for 2.5.41
Message-ID: <20021009224200.GF18646@kroah.com>
References: <20021009223848.GB18646@kroah.com> <20021009223945.GC18646@kroah.com> <20021009224015.GD18646@kroah.com> <20021009224041.GE18646@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021009224041.GE18646@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.743   -> 1.744  
#	drivers/hotplug/ibmphp_core.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/09	greg@kroah.com	1.744
# IBM PCI Hotplug: fix typos in previous patch
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Wed Oct  9 15:37:24 2002
+++ b/drivers/hotplug/ibmphp_core.c	Wed Oct  9 15:37:24 2002
@@ -731,8 +731,8 @@
 		bus_speed = PCI_SPEED_UNKNOWN;
 	}
 
-	info->cur_bus_speed_status = bus_speed;
-	info->max_bus_speed_status = slot_cur->hotplug_slot->info->max_bus_speed_status;
+	info->cur_bus_speed = bus_speed;
+	info->max_bus_speed = slot_cur->hotplug_slot->info->max_bus_speed;
 	// To do: bus_names 
 	
 	rc = pci_hp_change_slot_info (buffer, info);
