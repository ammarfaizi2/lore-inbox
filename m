Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVDBBA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVDBBA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 20:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVDBBA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 20:00:56 -0500
Received: from fmr22.intel.com ([143.183.121.14]:30151 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261642AbVDBBAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 20:00:52 -0500
Message-Id: <200504020100.j3210fg04870@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Industry db benchmark result on recent 2.6 kernels
Date: Fri, 1 Apr 2005 17:00:41 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU2dqAYWWaQP3D/RMi9o9IYROSavAAACMnQACn1B+A=
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Thursday, March 31, 2005 8:52 PM
> the current defaults for cache_hot_time are 10 msec for NUMA domains,
> and 2.5 msec for SMP domains. Clearly too low for CPUs with 9MB cache.
> Are you increasing cache_hot_time in your experiment? If that solves
> most of the problem that would be an easy thing to fix for 2.6.12.


Chen, Kenneth W wrote on Thursday, March 31, 2005 9:15 PM
> Yes, we are increasing the number in our experiments.  It's in the queue
> and I should have a result soon.

Hot of the press: bumping up cache_hot_time to 10ms on our db setup brings
2.6.11 performance on par with 2.6.9.  Theory confirmed.

- Ken


