Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUJFDoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUJFDoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 23:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUJFDoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 23:44:00 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:3765 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266808AbUJFDn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 23:43:58 -0400
Message-ID: <416369F9.7050205@yahoo.com.au>
Date: Wed, 06 Oct 2004 13:43:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrea Arcangeli <andrea@novell.com>, Robert Love <rml@novell.com>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost> <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au> <20041006020734.GA29383@havoc.gtf.org> <20041006031726.GK26820@dualathlon.random> <4163660A.4010804@pobox.com>
In-Reply-To: <4163660A.4010804@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Andrea Arcangeli wrote:
> 
>> So I disagree with your claim that preempt risks to hide inefficient
>> code, there are many other (probably easier) ways to detect inefficient
>> code than to check the latencies.
> 
> 
> 
> You're ignoring the argument :)
> 
> If users and developers are presented with the _impression_ that long 
> latency code paths don't exist, then nobody is motivated to profile them 
> (with any tool), much less fix them.
> 

But even without preempt you'd still have to profile the latency.

If anyone with !preempt notices unacceptable latency, then they can
report and/or profile and fix it. If not, then !preempt latency must
be acceptable.
