Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbULTXVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbULTXVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbULTXPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:15:00 -0500
Received: from fmr17.intel.com ([134.134.136.16]:49551 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261671AbULTXAf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:00:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]PCI Express Port Bus Driver
Date: Mon, 20 Dec 2004 15:00:26 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024074C1EF9@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]PCI Express Port Bus Driver
Thread-Index: AcTmwSqWBJJP/JdzSaa1AZSY4CQtrgAJe8kA
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 20 Dec 2004 23:00:27.0801 (UTC) FILETIME=[B264F090:01C4E6E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12/20/2004 10:24 AM, Greg KH wrote: 
> I think you might want to either get the PCI_GOANY code to work with
the
> pci express driver, or fix up the PCI_GOMMCONFIG case in the acpi
code,
> as no distro will ever enable PCI_GOMMCONFIG in the current case :)
>
> Sound ok?
Agree. I will update the patch to also work if PCI_GOANY is selected.

Thanks,
Long
