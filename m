Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266591AbUHTLw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266591AbUHTLw5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 07:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUHTLw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 07:52:56 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40353 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266591AbUHTLwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 07:52:41 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040820102732.GA14622@elte.hu>
References: <20040816040515.GA13665@elte.hu>
	 <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>
	 <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net>
	 <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
	 <1092972918.10063.11.camel@krustophenia.net>
	 <20040820081319.GA4321@elte.hu>
	 <1092993242.10063.66.camel@krustophenia.net>
	 <20040820102732.GA14622@elte.hu>
Content-Type: text/plain
Message-Id: <1093002758.10063.114.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 07:52:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 06:27, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > This is an extreme load situation, so I don't think it will be a
> > real-world problem.  I have not seen it under any normal workload.
> 
> well, 9 msecs is still not nice. I've been able to trigger larger than
> 10msec latencies too on a 2 GHz box.
> 
> > What about this one:
> > 
> > http://krustophenia.net/testresults.php?dataset=2.6.8.1-P4#/var/www/2.6.8.1-P4/netif_receive_skb_latency_trace.txt
> > 
> > This appears during normal use.
> 

Here is another:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P4#/var/www/2.6.8.1-P4/rt_run_flush_latency_trace.txt

Lee

