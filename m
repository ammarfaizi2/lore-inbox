Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWISJow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWISJow (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 05:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWISJow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 05:44:52 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:39940 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1751027AbWISJow convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 05:44:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: FW: FW:  [PATCH 2.6.17.3] Memory Management: High-Memory Scalability Issue
Date: Tue, 19 Sep 2006 15:13:53 +0530
Message-ID: <88299102B8C1F54BB5C8E47F30B2FBE2047C19A9@inblr-exch1.eu.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW:  [PATCH 2.6.17.3] Memory Management: High-Memory Scalability Issue
Thread-Index: AcbV7aZyXkO3CuSNQsSJ31EIhVDvjAF4lwGw
From: "Satapathy, Soumendu Sekhar" <Soumendu.Satapathy@in.unisys.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Sep 2006 09:44:38.0987 (UTC) FILETIME=[396EA1B0:01C6DBD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 
-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de] 
Sent: Tuesday, September 12, 2006 2:31 AM
To: Satapathy, Soumendu Sekhar
Cc: akpm@osdl.org; torvalds@osdl.org
Subject: Re: FW: [PATCH 2.6.17.3] Memory Management: High-Memory
Scalability Issue

On Monday 11 September 2006 08:24, Satapathy, Soumendu Sekhar wrote:
> Hi,
>
> http://lkml.org/lkml/2006/7/5/74
>
> This patch was tested successfully in a system with 4GB, 32GB and 64GB
RAM.
> Can it be considered for inclusion in the kernel.

Thanks for your contribution to Linux.

I'm not really deep enough into the high level swapping algorithm to
evaluate
your patch competently, but your result looks promising. Normally this
code is considered pretty fragile unfortunately so some more testing
would be definitely needed. It's good that you gave a clear rationale
on what you changed at least.

I would recommend to do perhaps do some benchmarks on smaller machines
with 
the patch too (just to make sure there are no regressions on them)  and 
possible try
a few more different workloads and then post on linux-mm@kvack.org.
There is 
where all the VM hackers tend to hang out.

-Andi

