Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271407AbTHHOlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271408AbTHHOlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:41:55 -0400
Received: from fmr05.intel.com ([134.134.136.6]:34296 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S271407AbTHHOlx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:41:53 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Updated MSI Patches
Date: Fri, 8 Aug 2003 07:41:46 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024015416E0@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updated MSI Patches
Thread-Index: AcNdNY05j4yjaSmQSQa4TnkdRphFEAAhVNcQ
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       <greg@kroah.com>, "long" <tlnguyen@snoqualmie.dp.intel.com>
X-OriginalArrivalTime: 08 Aug 2003 14:41:47.0161 (UTC) FILETIME=[31C29890:01C35DBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Seems like a lot of this file could go into a new file,
> drivers/pci/msi.c.  We'll want to share as much code as possible across
> all Linux architectures.
Agree. Next update release will incorporate your feedback.

Thanks,
Long


-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Thursday, August 07, 2003 3:45 PM
To: long
Cc: linux-kernel@vger.kernel.org; Nakajima, Jun; Nguyen, Tom L;
greg@kroah.com
Subject: Re: Updated MSI Patches


long wrote:


> diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/pci_msi.c linux-2.6.0-test2-create-msi/arch/i386/kernel/pci_msi.c
> --- linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/pci_msi.c	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.0-test2-create-msi/arch/i386/kernel/pci_msi.c	2003-08-06 09:47:02.000000000 -0400

Seems like a lot of this file could go into a new file, 
drivers/pci/msi.c.  We'll want to share as much code as possible across 
all Linux architectures.

	Jeff


