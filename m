Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTJWVuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 17:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTJWVuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 17:50:20 -0400
Received: from fmr06.intel.com ([134.134.136.7]:16565 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261812AbTJWVuL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 17:50:11 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Date: Thu, 23 Oct 2003 14:50:06 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304B04F@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Thread-Index: AcOZoWgEZkf6LJTcSVO53aBmcaR6AwABV+IgAAHjfmA=
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Moore, Robert" <robert.moore@intel.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Dominik Brodowski" <linux@brodo.de>
X-OriginalArrivalTime: 23 Oct 2003 21:50:07.0968 (UTC) FILETIME=[A0078600:01C399AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Me too, because it would be consistent with the other ones; i.e. how the
user perceives them.

	Jun
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Moore, Robert
> Sent: Thursday, October 23, 2003 1:48 PM
> To: Pavel Machek; Pallipadi, Venkatesh
> Cc: cpufreq@www.linux.org.uk; linux-kernel@vger.kernel.org;
linux-acpi;
> Nakajima, Jun; Mallick, Asit K; Dominik Brodowski
> Subject: RE: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI
P-
> state driver
> 
> 
> I would vote for "cpufreq_dynamic"
> 
> Bob
> 
> 
> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Thursday, October 23, 2003 7:17 AM
> To: Pallipadi, Venkatesh
> Cc: cpufreq@www.linux.org.uk; linux-kernel@vger.kernel.org;
linux-acpi;
> Nakajima, Jun; Mallick, Asit K; Dominik Brodowski
> Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI
> P-state driver
> 
> Hi!
> 
> > Patch 3/3: New dynamic cpufreq driver (called
> > DemandBasedSwitch driver), which periodically monitors CPU
> > usage and changes the CPU frequency based on the demand.
> >
> > diffstat dbs3.patch
> > drivers/cpufreq/Kconfig       |   25 ++++
> > drivers/cpufreq/Makefile      |    1
> > drivers/cpufreq/cpufreq_dbs.c |  214
> >
> Could you name it cpufreq_demand? We have enough
> TLAs as is.
> 				Pavwl
> 
> 
> --
> 				Pavel
> Written on sharp zaurus, because my Velo1 broke. If you have Velo you
> don't need...
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
