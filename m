Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751843AbWISJpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWISJpZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 05:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWISJpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 05:45:24 -0400
Received: from usea-naimss2.unisys.com ([192.61.61.104]:12560 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S1751843AbWISJpW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 05:45:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: FW: FW:  [PATCH 2.6.17.3] Memory Management: High-MemoryScalability Issue
Date: Tue, 19 Sep 2006 15:14:15 +0530
Message-ID: <88299102B8C1F54BB5C8E47F30B2FBE2047C19AD@inblr-exch1.eu.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW:  [PATCH 2.6.17.3] Memory Management: High-MemoryScalability Issue
Thread-Index: AcbV8tRBzZyutpoASiWjXyUua4ZPVwF3U9zQ
From: "Satapathy, Soumendu Sekhar" <Soumendu.Satapathy@in.unisys.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Sep 2006 09:45:19.0972 (UTC) FILETIME=[51DC7240:01C6DBD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Tuesday, September 12, 2006 4:07 AM
To: Andi Kleen
Cc: Satapathy, Soumendu Sekhar; torvalds@osdl.org
Subject: Re: FW: [PATCH 2.6.17.3] Memory Management:
High-MemoryScalability Issue

On Mon, 11 Sep 2006 23:01:25 +0200
Andi Kleen <ak@suse.de> wrote:

> On Monday 11 September 2006 08:24, Satapathy, Soumendu Sekhar wrote:
> > Hi,
> >
> > http://lkml.org/lkml/2006/7/5/74
> >
> > This patch was tested successfully in a system with 4GB, 32GB and
64GB RAM.
> > Can it be considered for inclusion in the kernel.
> 
> Thanks for your contribution to Linux.
> 
> I'm not really deep enough into the high level swapping algorithm to
evaluate
> your patch competently, but your result looks promising. Normally this
> code is considered pretty fragile unfortunately so some more testing
> would be definitely needed. It's good that you gave a clear rationale
> on what you changed at least.
> 
> I would recommend to do perhaps do some benchmarks on smaller machines
with 
> the patch too (just to make sure there are no regressions on them)
and 
> possible try
> a few more different workloads and then post on linux-mm@kvack.org.
There is 
> where all the VM hackers tend to hang out.
> 

Yes, I've tucked this patch away to take a closer look at, probably late
this week.

