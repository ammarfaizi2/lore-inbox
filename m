Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbTILRBW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTILRBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:01:22 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:30696 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S261767AbTILRBT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:01:19 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Hyperthreading: easiest userland method?
Date: Fri, 12 Sep 2003 10:00:54 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304A789@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hyperthreading: easiest userland method?
Thread-Index: AcN5PFvN6pKMTa+SSs6oThAqfuCh2AAEqaIg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Dan Behman" <dbehman@ca.ibm.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Sep 2003 17:00:55.0412 (UTC) FILETIME=[6E29DB40:01C3794F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For licensing purposes, we recommend the number of the physical
packages, rather than the number of logical processors. We can provide a
tool (with source code) that counts the number of the physical packages
in the system.

Thanks,
Jun

> -----Original Message-----
> From: Dan Behman [mailto:dbehman@ca.ibm.com]
> Sent: Friday, September 12, 2003 7:41 AM
> To: linux-kernel@vger.kernel.org
> Subject: Hyperthreading: easiest userland method?
> 
> Hi,
> 
> I have a need to programmatically determine whether or not
hyperthreading
> is enabled (and in use) for licensing reasons in my application.
> Currently, I know of two ways to do this:
> 
> 1) parse /proc/cpuinfo for "processor id"
> 2) port Intel's documented method (written for Windows) to directly
query
> the CPUs
> 
> Both methods have drawbacks - 1) relying on specific text that could
> change
> is a bad idea; 2) this doesn't take into account whether or not Linux
> and/or the BIOS is making use of the hyperthreading.
> 
> From scouring the archives and the net, it doesn't seem like there's
any
> API that currently exists, but perhaps I've missed something.
> /proc/cpuinfo gathers its information from somewhere - is there a way
in
> userland to bypass /proc/cpuinfo and directly get this data manually?
> 
> I'm interested in both 2.4 and 2.6 implementations and would like to
be
> personally CC'ed on any repsonses.
> 
> Thanks in advance!
> 
> Dan Behman.
> IBM Canada Ltd.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
