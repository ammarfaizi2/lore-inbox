Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289921AbSAKMEk>; Fri, 11 Jan 2002 07:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289922AbSAKMEU>; Fri, 11 Jan 2002 07:04:20 -0500
Received: from over.ny.us.ibm.com ([32.97.182.111]:27350 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289921AbSAKMEM>; Fri, 11 Jan 2002 07:04:12 -0500
Date: Wed, 9 Jan 2002 09:40:34 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Message-ID: <20020109094034.C1149@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20020108193904.A1068@w-mikek2.beaverton.ibm.com> <Pine.LNX.4.33.0201091122060.2276-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201091122060.2276-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Jan 09, 2002 at 11:25:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 11:25:43AM +0100, Ingo Molnar wrote:
> 
> On Tue, 8 Jan 2002, Mike Kravetz wrote:
> 
> > --------------------------------------------------------------------
> > Chat - VolanoMark simulator.  Result is a measure of throughput.
> >        Higher is better.
> 
> very interesting numbers, nice work Mike! I'd suggest the following
> additional test: please also run tests like VolanoMark with 'nice -n 19'.
> The O(1) scheduler's task-penalty method works in our favor in this case,
> since we know the test is CPU-bound we can move all processes to nice
> level 19.
> 
> 	Ingo

I'll do that in the next go around.  Right now, I'm trying to get some
TPC-H results.

-- 
Mike
