Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266592AbUFWRic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266592AbUFWRic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 13:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266596AbUFWRic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 13:38:32 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:36356 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266592AbUFWRia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 13:38:30 -0400
Message-ID: <40D9C48C.4060004@techsource.com>
Date: Wed, 23 Jun 2004 13:57:32 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Marcus Hartig <m.f.h@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: status of Preemptible Kernel 2.6.7
References: <40D9B20A.4070409@web.de>
In-Reply-To: <40D9B20A.4070409@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcus Hartig wrote:
> Hello,
> 
> how is now the status of the preemptible feature of the kernel 2.6.7. 
> Should preempt be used for desktop systems (like in the help menu) or 
> should it not really?
> 
> I have made tests with the alsa-latency-test, where it not really 
> reduces the latency of the kernel and gives a little bit lower 
> performance of the whole system.


I vaguely recall someone recently talking about eliminating preempt by 
improving low-latency.  See, if everything were ideal, we wouldn't need 
preempt, because all drivers would yield the CPU at appropriate times. 
Supposedly, preempt introduces some undesirable overhead.

Perhaps we could turn preempt into some kind of watch-dog.  If a kernel 
thread doesn't behave, it gets killed.  :)

