Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbULRAjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbULRAjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbULRAjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:39:11 -0500
Received: from fmr20.intel.com ([134.134.136.19]:7079 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262417AbULRAiN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:38:13 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]PCI Express Port Bus Driver
Date: Fri, 17 Dec 2004 16:37:26 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024074742C7@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]PCI Express Port Bus Driver
Thread-Index: AcTklVO6zy6CV1JFSmWLbte2k2g1xwAA9sow
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 18 Dec 2004 00:37:28.0729 (UTC) FILETIME=[C0B2D090:01C4E499]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, December 17, 2004 4:05 PM, Greg KH wrote: 
>> +struct bus_type pcie_port_bus_type = {
>> +	.name 		= "PCIE port bus",
>
> Ick, that puts spaces in the sysfs directory.  Why not just use
> "pci_express"?
Agree. Will update the patch to reflect your input.

Thanks,
Long
