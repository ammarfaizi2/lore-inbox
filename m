Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbSLFRr1>; Fri, 6 Dec 2002 12:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSLFRr1>; Fri, 6 Dec 2002 12:47:27 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:15123 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264931AbSLFRr0>;
	Fri, 6 Dec 2002 12:47:26 -0500
Date: Fri, 6 Dec 2002 09:54:39 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI Hotplug changes for 2.4.20
Message-ID: <20021206175439.GI10444@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an update for the PCI Hotplug ACPI driver.

Please pull from:  bk://linuxusb.bkbits.net/pci_hp-2.4

The raw patch will follow.

thanks,

greg k-h

 drivers/hotplug/Makefile       |    3 
 drivers/hotplug/acpiphp.h      |   20 +--
 drivers/hotplug/acpiphp_core.c |  215 ++++++++++++++++++++++---------------
 drivers/hotplug/acpiphp_glue.c |  232 +++++++++++++++++++----------------------
 drivers/hotplug/acpiphp_pci.c  |  148 +++++++-------------------
 drivers/hotplug/acpiphp_res.c  |   59 ++++------
 6 files changed, 314 insertions(+), 363 deletions(-)
-----

ChangeSet@1.828, 2002-12-06 09:31:02-08:00, t-kouchi@mvf.biglobe.ne.jp
  [PATCH] ACPI PCI hotplug updates
  
  These are updates of the acpiphp driver for 2.4
  This is mainly for backporting of bugfixes in 2.5 to 2.4.
  Please apply.
    - backport of 2.5 changes & bugfixes
    - whitespace cleanup
    - message cleanup

 drivers/hotplug/Makefile       |    3 
 drivers/hotplug/acpiphp.h      |   20 +--
 drivers/hotplug/acpiphp_core.c |  215 ++++++++++++++++++++++---------------
 drivers/hotplug/acpiphp_glue.c |  232 +++++++++++++++++++----------------------
 drivers/hotplug/acpiphp_pci.c  |  148 +++++++-------------------
 drivers/hotplug/acpiphp_res.c  |   59 ++++------
 6 files changed, 314 insertions(+), 363 deletions(-)
------

