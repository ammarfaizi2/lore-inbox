Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTJWUr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTJWUr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:47:58 -0400
Received: from fmr06.intel.com ([134.134.136.7]:59522 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261731AbTJWUr4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:47:56 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Date: Thu, 23 Oct 2003 13:47:49 -0700
Message-ID: <CFF522B18982EA4481D3A3E23B83141C24B4DF@orsmsx407.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Thread-Index: AcOZoWgEZkf6LJTcSVO53aBmcaR6AwABV+Ig
From: "Moore, Robert" <robert.moore@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Dominik Brodowski" <linux@brodo.de>
X-OriginalArrivalTime: 23 Oct 2003 20:47:50.0651 (UTC) FILETIME=[EC6A34B0:01C399A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would vote for "cpufreq_dynamic"

Bob


-----Original Message-----
From: Pavel Machek [mailto:pavel@ucw.cz] 
Sent: Thursday, October 23, 2003 7:17 AM
To: Pallipadi, Venkatesh
Cc: cpufreq@www.linux.org.uk; linux-kernel@vger.kernel.org; linux-acpi;
Nakajima, Jun; Mallick, Asit K; Dominik Brodowski
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI
P-state driver

Hi!

> Patch 3/3: New dynamic cpufreq driver (called 
> DemandBasedSwitch driver), which periodically monitors CPU 
> usage and changes the CPU frequency based on the demand.
> 
> diffstat dbs3.patch 
> drivers/cpufreq/Kconfig       |   25 ++++
> drivers/cpufreq/Makefile      |    1 
> drivers/cpufreq/cpufreq_dbs.c |  214
> 
Could you name it cpufreq_demand? We have enough
TLAs as is.
				Pavwl


-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you
don't need...

