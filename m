Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311611AbSCNNNm>; Thu, 14 Mar 2002 08:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311613AbSCNNNc>; Thu, 14 Mar 2002 08:13:32 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:16119 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S311611AbSCNNNV>; Thu, 14 Mar 2002 08:13:21 -0500
Date: Thu, 14 Mar 2002 18:46:09 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020314184609.D15394@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020313085217.GA11658@krispykreme> <460695164.1016001894@[10.10.2.3]> <20020314112725.GA2008@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314112725.GA2008@krispykreme>; from anton@samba.org on Thu, Mar 14, 2002 at 10:27:26PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 10:27:26PM +1100, Anton Blanchard wrote:
>  
> > >    554 .d_lookup                               
> > 
> > Did you try the dcache patches?
> 
> Not for this, I did do some benchmarking of the RCU dcache patches a
> while ago which I should post.

Please do ;-) This shows why we need to ease the pressure on dcache_lock.

> 
> > Can you publish lockmeter stats?
> 
> I didnt get a chance to run lockmeter, I tend to use the kernel profiler
> and use a hacked readprofile (originally from tridge) that displays
> profile hits vs assembly instruction. Thats usually good enough to work
> out which spinlocks are a problem.

Is this a PPC only hack ? Also, where can I get it ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
