Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289741AbSBESiz>; Tue, 5 Feb 2002 13:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289752AbSBESip>; Tue, 5 Feb 2002 13:38:45 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:55962 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289741AbSBESib>; Tue, 5 Feb 2002 13:38:31 -0500
Date: Wed, 6 Feb 2002 00:11:13 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Christoph Hellwig <hch@ns.caldera.de>, Andrea Arcangeli <andrea@suse.de>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Paul McKenney <paul.mckenney@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New Read-Copy Update patch
Message-ID: <20020206001113.C427@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <200202051654.g15GsWH01780@ns.caldera.de> <Pine.LNX.4.44.0202051156300.7240-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0202051156300.7240-100000@devserv.devel.redhat.com>; from mingo@redhat.com on Tue, Feb 05, 2002 at 11:57:07AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 11:57:07AM -0500, Ingo Molnar wrote:
> 
> On Tue, 5 Feb 2002, Christoph Hellwig wrote:
> 
> > > 3. A per-cpu timer support ? - This will allow us to get rid of the krcud
> > >    stuff and make RCU even simpler.
> > 
> > Something like http://people.redhat.com/mingo/scalable-timers-patches/smptimers-2.4.16-A0?
> > 
> > Ingo, Linus:  Any chance to see that in 2.5 soon?
> 
> i'll post an updated smptimers patch soon after the scheduler has settled
> down.

Hi Ingo,

Unless you have new code that updates the patch, I can take a stab
at porting it to 2.5. Let me know if that is ok.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
