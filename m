Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSJJVrg>; Thu, 10 Oct 2002 17:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbSJJVrf>; Thu, 10 Oct 2002 17:47:35 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:33550 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262446AbSJJVrA>;
	Thu, 10 Oct 2002 17:47:00 -0400
Date: Thu, 10 Oct 2002 14:48:38 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI Hotplug fixes for 2.4.20-pre10
Message-ID: <20021010214838.GE27523@kroah.com>
References: <20021010214455.GA27523@kroah.com> <20021010214527.GB27523@kroah.com> <20021010214549.GC27523@kroah.com> <20021010214625.GD27523@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010214625.GD27523@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.740   -> 1.741  
#	drivers/hotplug/ibmphp_core.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/10	greg@kroah.com	1.741
# IBM PCI Hotplug driver: typo fix for previous patch.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Thu Oct 10 14:44:38 2002
+++ b/drivers/hotplug/ibmphp_core.c	Thu Oct 10 14:44:38 2002
@@ -731,8 +731,8 @@
 		bus_speed = PCI_SPEED_UNKNOWN;
 	}
 
-	info->cur_bus_speed_status = bus_speed;
-	info->max_bus_speed_status = slot_cur->hotplug_slot->info->max_bus_speed_status;
+	info->cur_bus_speed = bus_speed;
+	info->max_bus_speed = slot_cur->hotplug_slot->info->max_bus_speed;
 	// To do: bus_names 
 	
 	rc = pci_hp_change_slot_info (buffer, info);
