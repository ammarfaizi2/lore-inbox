Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVCNR1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVCNR1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVCNR1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:27:41 -0500
Received: from fmr20.intel.com ([134.134.136.19]:1963 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261636AbVCNR1b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:27:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] drivers/pci/pci-acpi.c: possible cleanups
Date: Mon, 14 Mar 2005 09:26:10 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50240807099C@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] drivers/pci/pci-acpi.c: possible cleanups
Thread-Index: AcUnUqriZgL2YhnnTNaBYrb75bxujwBZ6dYA
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <gregkh@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>,
       "Brown, Len" <len.brown@intel.com>, <acpi-devel@lists.sourceforge.net>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 14 Mar 2005 17:26:08.0399 (UTC) FILETIME=[E8C219F0:01C528BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, March 12, 2005 2:27 PM Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - pci-acpi.c: make OSC_UUID static
> - remove the following unused functions:
>  - pci-acpi.c: acpi_query_osc
>  - pci-acpi.c: pci_osc_support_set
> - remove the following unneeded EXPORT_SYMBOL's:
>  - pci-acpi.c: pci_osc_support_set
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>

Please do not remove. These above functions, implemented for _OSC usage,
are used by PCI Express Native Hot Plug and PCI Express Advanced Error
Reporting drivers.

Thanks,
Long
