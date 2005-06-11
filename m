Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVFKHoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVFKHoq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 03:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVFKHoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 03:44:46 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:1663 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261636AbVFKHom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:44:42 -0400
Message-ID: <42AA9651.4050404@yahoo.com.au>
Date: Sat, 11 Jun 2005 17:44:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       karim@opersys.com, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
References: <42AA6A6B.5040907@opersys.com> <20050611070845.GA4609@elte.hu>
In-Reply-To: <20050611070845.GA4609@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> could you send me the .config you used for the PREEMPT_RT tests? Also, 
> you used -47-08, which was well prior the current round of performance 
> improvements, so you might want to re-run with something like -48-06 or 
> better.
> 

The other thing that would be really interesting is to test latencies
of various other kernel functionalities in the RT kernel (eg. message
passing, maybe pipe or localhost read/write, signals, fork/clone/exit,
mmap/munmap, faulting in shared memory, or whatever else is important
to the RT crowd).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
