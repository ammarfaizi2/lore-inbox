Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVC1UBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVC1UBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVC1UBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:01:17 -0500
Received: from fmr21.intel.com ([143.183.121.13]:3774 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262055AbVC1UBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:01:15 -0500
Message-Id: <200503282001.j2SK16g22781@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Dave Hansen'" <haveblue@us.ibm.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Industry db benchmark result on recent 2.6 kernels
Date: Mon, 28 Mar 2005 12:01:06 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUzz2JiRH8SsZx+RwWB91pANkmlcQAACRGw
In-Reply-To: <1112039416.2087.25.camel@localhost>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 11:33 -0800, Chen, Kenneth W wrote:
> We will be taking db benchmark measurements more frequently from now on with
> latest kernel from kernel.org (and make these measurements on a fixed interval).
> By doing this, I hope to achieve two things: one is to track base kernel
> performance on a regular base; secondly, which is more important in my opinion,
> is to create a better communication flow to the kernel developers and to keep
> all interested party well informed on the kernel performance for this enterprise
> workload.

Dave Hansen wrote on Monday, March 28, 2005 11:50 AM
> I'd guess that doing it on kernel.org is too late, sometimes.  How high
> is the overhead of doing a test?  Would you be able to test each -mm
> release?  It's somewhat easier to toss something out of -mm for
> re-review than it is out of Linus's tree.

The overhead is fairly high to run the benchmark.  It's not a one minute run.
(more or less like a 5 hour exercise.  Benchmark run time along is 3+ hours).
-mm has so many stuff, I'm not sure we would have the bandwidth to do a search
on which patch trigger N% regression, etc.  Let me try the base kernel first
and if resources are available, I can attempt to do it on -mm tree.


