Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbUKOTnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbUKOTnH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 14:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbUKOTnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 14:43:07 -0500
Received: from fmr19.intel.com ([134.134.136.18]:16569 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261665AbUKOTnF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 14:43:05 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] PCI cleanups
Date: Mon, 15 Nov 2004 11:41:10 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502406F1D41C@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE: [2.6 patch] PCI cleanups
Thread-Index: AcTLSw8W9zX1ojfVTWqFH2ciZx2qGA==
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: <bunk@stusta.de>
Cc: <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Roland Dreier" <roland@topspin.com>
X-OriginalArrivalTime: 15 Nov 2004 19:41:12.0303 (UTC) FILETIME=[0FE777F0:01C4CB4B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 12, 2004 7:02 PM Adrian Bunk wrote:
> The patch below does some cleanups in the PCI code:
> - make OSC_UUID in drivers/pci/pci-acpi.c static
> - remove the completely unused drivers/pci/hotplug/pciehp_sysfs.c
> - remove other unused code
Your patch mistakenly removes PCI MSI-X support in the kernel. Please
do not remove PCI MSI-X support code.  

Thanks,
Long  
