Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVDAFPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVDAFPf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 00:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVDAFPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 00:15:30 -0500
Received: from fmr22.intel.com ([143.183.121.14]:15075 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262628AbVDAFPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 00:15:13 -0500
Message-Id: <200504010514.j315Exg26006@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Industry db benchmark result on recent 2.6 kernels
Date: Thu, 31 Mar 2005 21:14:59 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU2dqAYWWaQP3D/RMi9o9IYROSavAAACMnQ
In-Reply-To: <20050401045219.GC22753@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Thursday, March 31, 2005 8:52 PM
> the current scheduler queue in -mm has some experimental bits as well
> which will reduce the amount of balancing. But we cannot just merge them
> an bloc right now, there's been too much back and forth in recent
> kernels. The safe-to-merge-for-2.6.12 bits are already in -BK.

I agree, please give me some time to go through these patches on our db
setup.

> the current defaults for cache_hot_time are 10 msec for NUMA domains,
> and 2.5 msec for SMP domains. Clearly too low for CPUs with 9MB cache.
> Are you increasing cache_hot_time in your experiment? If that solves
> most of the problem that would be an easy thing to fix for 2.6.12.

Yes, we are increasing the number in our experiments.  It's in the queue
and I should have a result soon.


