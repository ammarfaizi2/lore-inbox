Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUCaB5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUCaB5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:57:10 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:10637 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261610AbUCaB5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:57:00 -0500
Message-ID: <406A2545.5020605@yahoo.com.au>
Date: Wed, 31 Mar 2004 11:56:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: efocht@hpce.nec.com, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <1DF7H-22Y-11@gated-at.bofh.it> <1DL3x-7iG-7@gated-at.bofh.it>	<1DLGd-7TS-17@gated-at.bofh.it> <1FmNz-72J-73@gated-at.bofh.it>	<1FnzJ-7IW-15@gated-at.bofh.it> <m34qs665di.fsf@averell.firstfloor.org>
In-Reply-To: <m34qs665di.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> writes:
> 
> 
>>I'm with Martin here, we are just about to merge all this
>>sched-domains stuff. So we should at least wait until after
>>that. And of course, *nothing* gets changed without at least
>>one benchmark that shows it improves something. So far
>>nobody has come up to the plate with that.
> 
> 
> Hmm? I post numbers all the time.
> 

Yeah I know - it just so happened that you got *worse*
performance from Ingo's balance-on-clone than by simply
decreasing the balancing interval just now :P

Although it is probably just because balance-on-clone is
not tuned well.

I've said all along that it will probably be a good thing
to do if it is implemented correctly, but 1. we need some
good numbers, and 2. let's not stuff it in at the same
time sched-domains goes in because it is a fundamentally
different concept.
