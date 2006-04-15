Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbWDOVST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbWDOVST (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 17:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWDOVST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 17:18:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751618AbWDOVSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 17:18:18 -0400
Date: Sat, 15 Apr 2006 14:17:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: Clear performance regression on reaim7 in 2.6.15-git6
Message-Id: <20060415141744.042231a8.akpm@osdl.org>
In-Reply-To: <4441452F.3060009@google.com>
References: <4441452F.3060009@google.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@google.com> wrote:
>
> OK, looking back through the perf results, these two graphs clearly show
> a perf regression in reaim7 from 2.6.15 to 2.6.16-rc1. We're loosing 
> over 50% of the performance.
> 
> http://test.kernel.org/abat/perf/reaim.moe.png
> http://test.kernel.org/abat/perf/reaim.elm3b67.png

Something very bad has allegedly been happening in -mm.  It would have been
nice to have heard about this problem in that multi-month wwindow there. 
Does no human look at these numbers?

> Drilling down (there's not enough detail on the graphs for releases that
> far back), I see it's actually between -git5 and -git6
> 
> These are both ia-32 NUMA machines, one is an x440, the other is NUMA-Q.

The 2.6.15-git5 -> 2.6.15-git6 diff is enormous.  I'd assume some bad thing
got transferred into mainline then.

How does one reproduce this?  Which type of filesystem, which command
line/config file?

Thanks.
