Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752515AbWAFRpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbWAFRpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbWAFRpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:45:42 -0500
Received: from fmr21.intel.com ([143.183.121.13]:27828 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1752515AbWAFRpl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:45:41 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] ia64: change defconfig to NR_CPUS==1024
Date: Fri, 6 Jan 2006 09:45:20 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F055A7B6B@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ia64: change defconfig to NR_CPUS==1024
Thread-Index: AcYS5s8HBWi7br7lTE6btroyJrPCdgAACjcQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Matthew Wilcox" <matthew@wil.cx>
Cc: "Arjan van de Ven" <arjan@infradead.org>, <hawkes@sgi.com>,
       "Tony Luck" <tony.luck@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Jack Steiner" <steiner@sgi.com>, "Dan Higgins" <djh@sgi.com>,
       "John Hesterberg" <jh@sgi.com>, "Greg Edwards" <edwardsg@sgi.com>
X-OriginalArrivalTime: 06 Jan 2006 17:45:21.0604 (UTC) FILETIME=[F738B840:01C612E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Why can't we keep the default below 64?  Surely the 0.1% of the market
>which needs more than 64 cpus can recompile their kernel ...

I suppose that depends on your expectations from defconfig.  In my
mind its the one that builds into a kernel that will boot and run
on just about any box.  People who want to get a bit of extra performance
will do the re-compilation to strip out the bits that they don't want
and tune down limits that are set higher than they need.  I only
ever boot a defconfig kernel to check that it still works, my systems
all run tiger_defconfig/zx1_defconfig based most of the time.  But
perhaps I'm the weird one?

There are quite a few >16 socket boxes out there, which will give
you >64 cpus with Montecito ... so I don't think that the >64 cpu
system is going to remain in the noise for long.

-Tony
