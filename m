Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318602AbSHUSZ2>; Wed, 21 Aug 2002 14:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318608AbSHUSZ2>; Wed, 21 Aug 2002 14:25:28 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:47620 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318602AbSHUSZ0>;
	Wed, 21 Aug 2002 14:25:26 -0400
Date: Wed, 21 Aug 2002 11:24:06 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI Hotplug changes for 2.4.20-pre4
Message-ID: <20020821182406.GB1553@kroah.com>
References: <20020821182346.GA1553@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020821182346.GA1553@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 24 Jul 2002 17:19:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.587   -> 1.588  
#	Documentation/Configure.help	1.120   -> 1.121  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/20	greg@kroah.com	1.588
# added Configure.help entry for the ACPI PCI Hotplug driver.
# --------------------------------------------
#
diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Wed Aug 21 11:23:27 2002
+++ b/Documentation/Configure.help	Wed Aug 21 11:23:27 2002
@@ -3644,6 +3644,16 @@
 
   When in doubt, say N.
 
+ACPI PCI Hotplug driver
+CONFIG_HOTPLUG_PCI_ACPI
+  Say Y here if you have a system that supports PCI Hotplug using
+  ACPI.
+
+  This code is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called acpiphp.o. If you want to compile it
+  as a module, say M here and read <file:Documentation/modules.txt>.
+
 MCA support
 CONFIG_MCA
   MicroChannel Architecture is found in some IBM PS/2 machines and
