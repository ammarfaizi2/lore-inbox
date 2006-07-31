Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWGaHUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWGaHUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWGaHUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:20:17 -0400
Received: from mga05.intel.com ([192.55.52.89]:5696 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932530AbWGaHUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:20:15 -0400
X-IronPort-AV: i="4.07,196,1151910000"; 
   d="scan'208"; a="107645874:sNHT25815174"
Subject: Re: [PATCH 2/4] PCI-Express AER implemetation: export
	pcie_port_bus_type
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <1154330118.27051.73.camel@ymzhang-perf.sh.intel.com>
References: <1154330118.27051.73.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Message-Id: <1154330319.27051.76.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 31 Jul 2006 15:18:39 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang, Yanmin <yanmin.zhang@intel.com>

Patch 2 exports pcie_port_bus_type.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

--- linux-2.6.18-rc3/drivers/pci/pcie/portdrv_bus.c	2006-07-31 14:38:48.000000000 +0800
+++ linux-2.6.18-rc3_aer/drivers/pci/pcie/portdrv_bus.c	2006-07-31 14:43:34.000000000 +0800
@@ -76,3 +76,6 @@ static int pcie_port_bus_resume(struct d
 		driver->resume(pciedev);
 	return 0;
 }
+
+EXPORT_SYMBOL(pcie_port_bus_type);
+
