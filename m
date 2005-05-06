Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVEFSAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVEFSAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 14:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVEFSAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 14:00:20 -0400
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:44293 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S261255AbVEFSAQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 14:00:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeonprocessors in EM64T mode (x86_64)
Date: Fri, 6 May 2005 12:59:54 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B4B@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeonprocessors in EM64T mode (x86_64)
Thread-Index: AcVSYeRgnhrFn3MURxWTC7p8Vo6pYQAAyJxg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Len Brown" <len.brown@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 May 2005 17:59:55.0444 (UTC) FILETIME=[68DD5F40:01C55265]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> A run-time solution would be preferable to adding a config 
> option that only changes the default behaviour.
> 
> In general, the more config options, the more kernels we 
> force distros to build and support.  We really want to going 
> the other way and simplifying, when possible.


Len and Zwane, I sure agree with you. I will take the config option out.
Would the APIC version be a good criteria to make a run-time decision
with Xeons? I know that everything Intel that can run EM64T has front
side bus (APIC version >= 20?). And I guess the boot parameter can still
be useful?

Thanks,
--Natalie 
