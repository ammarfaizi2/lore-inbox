Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTJURMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 13:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTJURMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 13:12:23 -0400
Received: from fmr06.intel.com ([134.134.136.7]:18399 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263195AbTJURMW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 13:12:22 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-statedriver
Date: Tue, 21 Oct 2003 10:12:14 -0700
Message-ID: <CFF522B18982EA4481D3A3E23B83141C24B4BC@orsmsx407.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-statedriver
Thread-Index: AcOXfvSGeoZq95RFQxuM4M5LuLIFCQAdstdw
From: "Moore, Robert" <robert.moore@intel.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>
Cc: "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Dominik Brodowski" <linux@brodo.de>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Therien, Guy" <guy.therien@intel.com>
X-OriginalArrivalTime: 21 Oct 2003 17:12:15.0520 (UTC) FILETIME=[79A65A00:01C397F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is exactly what I was looking at doing, looks like most of the work
is done.  I have some concerns about the actual algorithm used for
changing the CPU frequency (20%/80%), but this of course can be tuned.

I suspect that CPUs that have the capability of changing frequency
themselves would not use this particular governor.

You may want to make the sampling rate configurable at run time.

Bob


-----Original Message-----
From: Pallipadi, Venkatesh 
Sent: Monday, October 20, 2003 7:57 PM
To: cpufreq@www.linux.org.uk; linux-kernel@vger.kernel.org; linux-acpi
Cc: Mallick, Asit K; Nakajima, Jun; Dominik Brodowski
Subject: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI
P-statedriver
