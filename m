Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWGaDPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWGaDPu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 23:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWGaDPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 23:15:50 -0400
Received: from mga05.intel.com ([192.55.52.89]:21400 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932511AbWGaDPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 23:15:50 -0400
X-IronPort-AV: i="4.07,196,1151910000"; 
   d="scan'208"; a="107566616:sNHT38976168"
Subject: Re: [PATCH 3/5] PCI-Express AER implemetation: export
	pcie_port_bus_type
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <1154315439.27051.29.camel@ymzhang-perf.sh.intel.com>
References: <1154314837.27051.26.camel@ymzhang-perf.sh.intel.com>
	 <1154315439.27051.29.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Message-Id: <1154315653.27051.32.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 31 Jul 2006 11:14:13 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang, Yanmin <yanmin.zhang@intel.com>

Patch 3 exports pcie_port_bus_type.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

--- linux-2.6.17/drivers/pci/pcie/portdrv_bus.c	2006-06-22 16:26:43.000000000 +0800
+++ linux-2.6.17_aer/drivers/pci/pcie/portdrv_bus.c	2006-07-13 09:21:38.000000000 +0800
@@ -76,3 +76,6 @@ static int pcie_port_bus_resume(struct d
 		driver->resume(pciedev);
 	return 0;
 }
+
+EXPORT_SYMBOL(pcie_port_bus_type);
+
