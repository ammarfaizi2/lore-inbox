Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUDMTie (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 15:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263712AbUDMTie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 15:38:34 -0400
Received: from fmr06.intel.com ([134.134.136.7]:24293 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263710AbUDMTi3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 15:38:29 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] PCI MSI Kconfig consolidation
Date: Tue, 13 Apr 2004 12:16:10 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502404058232@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] PCI MSI Kconfig consolidation
Thread-Index: AcQhdiLsLYqynXt0RVW/gucAc1x//AAEpbRw
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, <linux-kernel@vger.kernel.org>
Cc: <linux-ia64@vger.kernel.org>, "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 13 Apr 2004 19:16:31.0583 (UTC) FILETIME=[D41986F0:01C4218B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 13, Bjorn Helgaas wrote:

> This consolidates the PCI MSI configuration into drivers/pci/Kconfig,
> removing it from the i386, x86_64, and ia64 Kconfig.
>
> It also changes the default for ia64 from "y" to "n".  The default on
> i386 is "n" already, and I'm not sure why ia64 should be different.

It looks good; however, it may create a confusion on ia64 because ia64 
is already vector-based indexing. 

Thanks,
Long
