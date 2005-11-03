Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbVKCAYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbVKCAYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbVKCAYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:24:39 -0500
Received: from fmr18.intel.com ([134.134.136.17]:19587 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030210AbVKCAYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:24:39 -0500
Subject: [patch 0/4] pci: store PCI_INTERRUPT_PIN in pci_dev
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com,
       len.brown@intel.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Nov 2005 16:24:29 -0800
Message-Id: <1130977469.8321.37.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 03 Nov 2005 00:24:31.0445 (UTC) FILETIME=[F596B050:01C5E00C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For surprise removal for pci hotplug, we need the value of the 
PCI_INTERRUPT_PIN for determining the correct interrupt to 
disable.  These patches will store the pin value in the 
pci_dev structure, and then use it where appropriate.  

Patches 1-3 are resends, with patch 4 being new.  I just resent
everything so that there's no confusion on what's the latest.

--
