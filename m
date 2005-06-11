Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVFKX1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVFKX1h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 19:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVFKX1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 19:27:37 -0400
Received: from dvhart.com ([64.146.134.43]:47017 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261846AbVFKX1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 19:27:31 -0400
Date: Sat, 11 Jun 2005 16:27:34 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <674540000.1118532454@[10.10.2.4]>
In-Reply-To: <200506120820.05627.kernel@kolivas.org>
References: <20050607170853.3f81007a.akpm@osdl.org> <200506111522.30765.kernel@kolivas.org> <672740000.1118520822@[10.10.2.4]> <200506120820.05627.kernel@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Con Kolivas <kernel@kolivas.org> wrote (on Sunday, June 12, 2005 08:20:05 +1000):

> On Sun, 12 Jun 2005 06:13, Martin J. Bligh wrote:
>> --Con Kolivas <kernel@kolivas.org> wrote (on Saturday, June 11, 2005 > > 
> Great thanks. Here are rolled up all the reconsidered changes that apply
>> > directly to 2.6.12-rc6-mm1 -purely for testing purposes-. I'd be very
>> > grateful to see how this performed; it has been boot and stress tested at
>> > this end. If it shows detriment I'll have to make the smp nice changes
>> > more complex.
>> 
>> It's much better ... but still a degredation - see point p5181 on:
>> 
>> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/perf/kernbench.mo
>> e.png
>> 
>> Only really seems to hurt the NUMA box (the x440 one ... elm3b67 ... is
>> still trying to find it's ass with both hands). I'm not necessarily saying
>> it's a problem ... not sure what the benefits of the patch are, but it's a
>> data point, at least ?
> 
> Thanks a lot!
> 
> Just checking the numbering of the test runs with you. This is the blue line 
> order as plotted on the graph:
> 
> 5181 is with this patch
> 4947 is mm1?
> 5150 is mm1 with the 4 patches backed out
> 5081 is mm1 with the 4 patches backed out and Hz changed to 100?
> 5169 is ?

Until I get off my ass and write an html wrapper for the graphs, easiest
thing to do is just cross-reference to here:

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html

The +pXXXX numbers on the graph match the job numbers in the boxes. You 
can click on the patches down the left side, and see exactly what they 
were if you want.

M.


