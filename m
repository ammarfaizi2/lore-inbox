Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271106AbTHGXIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271107AbTHGXIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:08:04 -0400
Received: from fmr05.intel.com ([134.134.136.6]:57302 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S271106AbTHGXH5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:07:57 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Updated MSI Patches
Date: Thu, 7 Aug 2003 16:07:53 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AE7D@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updated MSI Patches
Thread-Index: AcNdNYrkDmckcZyTTaCpF1SdIrRz0wAAfbpA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <linux-kernel@vger.kernel.org>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       <greg@kroah.com>
X-OriginalArrivalTime: 07 Aug 2003 23:07:54.0441 (UTC) FILETIME=[BBA80B90:01C35D38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Seems like a lot of this file could go into a new file,
> drivers/pci/msi.c.  We'll want to share as much code as possible
across
> all Linux architectures.
Agree. 

At the same time, Long, you need to provide more info so that more
people can play with MSI. 

Jun

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com]
> Sent: Thursday, August 07, 2003 3:45 PM
> To: long
> Cc: linux-kernel@vger.kernel.org; Nakajima, Jun; Nguyen, Tom L;
> greg@kroah.com
> Subject: Re: Updated MSI Patches
> 
> long wrote:
> 
> 
> > diff -X excludes -urN linux-2.6.0-test2-create-
> vectorbase/arch/i386/kernel/pci_msi.c linux-2.6.0-test2-create-
> msi/arch/i386/kernel/pci_msi.c
> > --- linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/pci_msi.c
> 	1969-12-31 19:00:00.000000000 -0500
> > +++ linux-2.6.0-test2-create-msi/arch/i386/kernel/pci_msi.c	2003-08-
> 06 09:47:02.000000000 -0400
> 
> Seems like a lot of this file could go into a new file,
> drivers/pci/msi.c.  We'll want to share as much code as possible
across
> all Linux architectures.
> 
> 	Jeff
> 

