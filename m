Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbVDBARF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbVDBARF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbVDBAQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:16:15 -0500
Received: from fmr23.intel.com ([143.183.121.15]:3307 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262961AbVDAX4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:56:54 -0500
Message-Id: <200504012356.j31Nuig04242@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Grecko OSCP'" <grecko.lists@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux Kernel Performance Testing
Date: Fri, 1 Apr 2005 15:56:44 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU26KV3yozqTxG9SzODljVkCc7ZcQAJUHEA
In-Reply-To: <1c55c94505040110224ea1ebb6@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grecko OSCP wrote on Friday, April 01, 2005 10:22 AM
> I noticed yesterday a news article on Linux.org about more kernel
> performance testing being called for, and I decided it would be a nice
> project to try. I have 10 completely identical systems that can be
> used for this, and would like to get started while I know I have them
> for a while.
>
> However, I wanted to make sure I didn't waste time. My plan was to do
> all testing, prerelease, and release kernels from the 2.4, 2.5, and
> 2.6 trees, with both lmbench and the Linux Testing Project (LTP)
> benchmark suite. Will this help out? Is there anything else a person
> should do? With those two benchmarks, and all the kernels I mentioned,
> I could be done in about 25 days, at one kernel a machine a day. I
> assume it wouldn't matter what distribution was used, so long as its
> the same for all tests?

The 10 machines for running benchmarks is not a bad infrastructure to
start with.  However, it may not be sufficient to identify performance
regression.  The benchmarks that show regression in Linux kernel requires
huge infrastructure - lots of memory, disks, network and clients.  The
simple benchmarks sometime do not show regression and are usually well
covered by the community and OSDL.

As mentioned in another thread, we (as Intel) will take on the challenge
to do performance testing on a regular basis.  We have fairly extensive
hardware mix and infrastructure (large smp/numa box with lots of memory,
disk farm, network etc) to really stress the kernel, performance wise.


