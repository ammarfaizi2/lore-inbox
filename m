Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289504AbSBEQ5g>; Tue, 5 Feb 2002 11:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289657AbSBEQ50>; Tue, 5 Feb 2002 11:57:26 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:44618 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289504AbSBEQ5Q>; Tue, 5 Feb 2002 11:57:16 -0500
Date: Tue, 5 Feb 2002 11:57:07 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Dipankar Sarma <dipankar@in.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Paul McKenney <paul.mckenney@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New Read-Copy Update patch
In-Reply-To: <200202051654.g15GsWH01780@ns.caldera.de>
Message-ID: <Pine.LNX.4.44.0202051156300.7240-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Feb 2002, Christoph Hellwig wrote:

> > 3. A per-cpu timer support ? - This will allow us to get rid of the krcud
> >    stuff and make RCU even simpler.
> 
> Something like http://people.redhat.com/mingo/scalable-timers-patches/smptimers-2.4.16-A0?
> 
> Ingo, Linus:  Any chance to see that in 2.5 soon?

i'll post an updated smptimers patch soon after the scheduler has settled
down.

	Ingo

