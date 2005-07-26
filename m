Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVGZUBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVGZUBy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVGZUBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:01:53 -0400
Received: from fmr20.intel.com ([134.134.136.19]:44701 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261982AbVGZUBw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:01:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] RE: ACPI oddity
Date: Tue, 26 Jul 2005 13:00:05 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E0234E63A@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] RE: ACPI oddity
thread-index: AcWRXdQWKL2AmaJpSwamF0n96sUawwAQK91wAB99gPA=
From: "Moore, Robert" <robert.moore@intel.com>
To: "Brown, Len" <len.brown@intel.com>, "Bill Davidsen" <davidsen@tmr.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 26 Jul 2005 20:01:36.0016 (UTC) FILETIME=[D3CE0100:01C5921C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And in fact, some BIOS vendors purposely run their code through an
obfuscator which changes everything to things like ABC9 and XYZ4 or
C001, C002, etc.

> -----Original Message-----
> From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-
> admin@lists.sourceforge.net] On Behalf Of Brown, Len
> Sent: Monday, July 25, 2005 10:02 PM
> To: Bill Davidsen; Linux Kernel Mailing List
> Cc: acpi-devel@lists.sourceforge.net
> Subject: [ACPI] RE: ACPI oddity
> 
> >On a HT system, why does ACPI recognize CPU0 and CPU1, refer
> >to them as such in dmesg
> 
> This is the Linux CPU number. ie the namespace where 0
> is the boot processor and the others are numbered in
> the order that they were started.
> 
> > and then call them CPU1 and CPU2 in
> >/proc/acpi/processor?
> 
> These are arbitrary device identifiers written
> by the BIOS developer and foolishly advertised
> to the user by Linux.  The BIOS writer could have
> also called them ABC9 and XYZ4 and it would be
> equally valid.
> 
> We're planning to get rid of all the ACPI stuff
> in /proc and move to sysfs.  At that time we'll
> use device identifies that are deterministic,
> like cpu%d that /sys/devices/system uses today.
> 
> cheers,
> -Len
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id492&op=ick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
