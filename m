Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311565AbSCNUCb>; Thu, 14 Mar 2002 15:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311589AbSCNUCU>; Thu, 14 Mar 2002 15:02:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64659 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311565AbSCNUCG>; Thu, 14 Mar 2002 15:02:06 -0500
To: Erich Focht <efocht@ess.nec.de>
cc: Jesse Barnes <jbarnes@sgi.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Lse-tech] Re: Node affine NUMA scheduler 
In-Reply-To: Your message of Thu, 14 Mar 2002 17:11:59 +0100.
             <Pine.LNX.4.21.0203141709310.12844-100000@sx6.ess.nec.de> 
Date: Thu, 14 Mar 2002 12:00:18 -0800
Message-Id: <E16lbPH-000705-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Beware of optimizing for the benchmark.  In real life, exec is likely
a much better place for the balancing.

gerrit

In message <Pine.LNX.4.21.0203141709310.12844-100000@sx6.ess.nec.de>, > : Erich
 Focht writes:
> On Thu, 14 Mar 2002, Erich Focht wrote:
> 
> > the task is currently running. Hackbench might slow down a bit but
> > AIM7 should improve.
> 
> Grrr, AIM7 doesn't exec(), either :-( , so no initial balancing is
> done. I'll take that back into do_fork()...
> 
> Regards,
> Erich
> 
> 
> 
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 
