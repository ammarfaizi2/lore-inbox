Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280305AbRJaRHW>; Wed, 31 Oct 2001 12:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280306AbRJaRHM>; Wed, 31 Oct 2001 12:07:12 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:19944 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280305AbRJaRG4>; Wed, 31 Oct 2001 12:06:56 -0500
Date: Wed, 31 Oct 2001 09:07:03 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
Message-ID: <20011031090703.A1105@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011030161106.F1097@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0110301629400.1495-100000@blue1.dev.mcafeelabs.com> <20011030212940.A1037@w-mikek2.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011030212940.A1037@w-mikek2.sequent.com>; from kravetz@us.ibm.com on Tue, Oct 30, 2001 at 09:29:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 09:29:41PM -0800, Mike Kravetz wrote:
> 
> I'll kick off the all important 'kernel build benchmark' and have
> some results tomorrow.

--------------------------------------------------------------------
mkbench - Time how long it takes to compile the kernel.  On this
	8 CPU system we use 'make -j 8' and increase the number
	of makes run in parallel.  Result is average build time in
	seconds.
--------------------------------------------------------------------
# parallel makes       Vanilla Sched   MQ Sched         Xsched
--------------------------------------------------------------------
1			 56		 55		 61
2			105		105		105
3			156		156		154
4			206		206		205
5			257		257		256
6			308		308		307

-- 
Mike
