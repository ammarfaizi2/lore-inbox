Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130306AbRCESpw>; Mon, 5 Mar 2001 13:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130308AbRCESpm>; Mon, 5 Mar 2001 13:45:42 -0500
Received: from gateway.sequent.com ([192.148.1.10]:54810 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S130306AbRCESpc>; Mon, 5 Mar 2001 13:45:32 -0500
Date: Mon, 5 Mar 2001 10:41:18 -0800
From: Jonathan Lahr <lahr@sequent.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Jonathan Lahr <lahr@sequent.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel lock contention and scalability
Message-ID: <20010305104118.C6212@w-lahr.des.sequent.com>
In-Reply-To: <20010215104656.A6856@w-lahr.des.sequent.com> <3A98D5D3.6A6B6686@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A98D5D3.6A6B6686@colorfullife.com>; from manfred@colorfullife.com on Sun, Feb 25, 2001 at 10:52:19AM +0100
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Spraul [manfred@colorfullife.com] wrote:
>
> > lock contention work would be appreciated.  I'm aware of timer scalability
> > work ongoing at people.redhat.com/mingo/scalable-timers, but is anyone
> > working on reducing sem_ids contention?
>
> Is that really a problem?
> The contention is high, but the actual lost time is quite small.

I agree it isn't a major performance problem under that workload.  But, I
thought since the contention was high that other workloads which may
utilize it more might have shown it to be a significant problem.

> I've attached 2 changes that might reduce the contention, but it's just
> an idea, completely untested.

Thanks for the insight into the sempahore subsystem and the suggested fixes.

--
Jonathan Lahr
IBM Linux Technology Center
Beaverton, Oregon
lahr@us.ibm.com
503-578-3385

