Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTIPDEd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTIPDEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:04:33 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:10478 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261764AbTIPDDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:03:01 -0400
Message-ID: <1063681376.3f667d6089d17@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:02:56 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 3 of 15 -- /drivers/pci/pci.c
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 203.17.68.210
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes kernel-doc errors reported whilst doing
a make mandocs on 2.6-test4-bk5

Linus, please apply.

Cheers,
Mikal


--------------------------


diff -Nur linux-2.6.0-test4-bk5-mandocs/drivers/pci/pci.c
linux-2.6.0-test4-bk5-mandocs_tweaks/drivers/pci/pci.c
--- linux-2.6.0-test4-bk5-mandocs/drivers/pci/pci.c	2003-09-04
10:55:55.000000000 +1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/drivers/pci/pci.c	2003-09-09
16:09:35.000000000 +1000
@@ -126,11 +126,13 @@
 
 /**
  * pci_bus_find_capability - query for devices' capabilities 
- * @dev: PCI device to query
- * @cap: capability code
+ * @bus:   the PCI bus to query
+ * @devfn: PCI device to query
+ * @cap:   capability code
  *
  * Like pci_find_capability() but works for pci devices that do not have a
  * pci_dev structure set up yet. 
+ *
  * Returns the address of the requested capability structure within the
  * device's PCI configuration space or 0 in case the device does not
  * support it.

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
