Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291270AbSBGUOH>; Thu, 7 Feb 2002 15:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291262AbSBGUNx>; Thu, 7 Feb 2002 15:13:53 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:17939 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S291265AbSBGUMd>;
	Thu, 7 Feb 2002 15:12:33 -0500
Date: Thu, 7 Feb 2002 12:58:53 -0700
From: yodaiken@fsmlabs.com
To: Robert Love <rml@tech9.net>
Cc: Martin Wirth <Martin.Wirth@dlr.de>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au, torvalds@transmet.com, mingo@elte.hu, nigel@nrg.org
Subject: Re: [RFC] New locking primitive for 2.5
Message-ID: <20020207125853.B21354@hq.fsmlabs.com>
In-Reply-To: <3C629F91.2869CB1F@dlr.de> <1013107259.10430.29.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1013107259.10430.29.camel@phantasy>; from rml@tech9.net on Thu, Feb 07, 2002 at 01:40:59PM -0500
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 01:40:59PM -0500, Robert Love wrote:
> > To really take any benefit from a preemptible kernel a lot of spin locks
> > will have to be replaced by mutex locks. The combi-lock approach may
> > convince more people who typically fear the higher scheduling pressure
> > of sleeping locks to do so, if they can decide on each instance which
> > approach (spin of sleep) will be taken.
> 
> We shouldn't engage in wholesale changing of spinlocks to semaphores
> without a priority-inheritance mechanism.  And _that_ is the bigger
> issue ...

Cool. We can then have the Solaris "this usually doesn't fail on test" priority
inherit read/write lock.  I can hardly wait.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

