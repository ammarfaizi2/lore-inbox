Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263639AbRFARxY>; Fri, 1 Jun 2001 13:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263648AbRFARxO>; Fri, 1 Jun 2001 13:53:14 -0400
Received: from asooo.flowerfire.com ([63.104.96.247]:2564 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S263639AbRFARw6>; Fri, 1 Jun 2001 13:52:58 -0400
Message-Id: <200106011752.MAA09473@asooo.flowerfire.com>
Date: Fri, 1 Jun 2001 10:53:03 -0700
From: Ken Brownfield <brownfld@irridia.com>
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
Subject: Re: 2.4.5 VM
Cc: linux-kernel@vger.kernel.org
To: Miquel Colom Piza <m.colom@barcelo.com>
X-Mailer: Apple Mail (2.388)
In-Reply-To: <3B17CDCF.AABA522B@barcelo.com>
Mime-Version: 1.0 (Apple Message framework v388)
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd be forced to agree.  I have 2.4.x in limited production, and with 
the exception of the HP/APIC fatal issues that have a "noapic" 
work-around, I have had no problem at all with any of the 2.4.x kernels 
I've used.

Open software by definition will never reach the kind of monolithic 
stability that years of code freeze requires.  Linux (especially 2.4.x) 
offers too much in return, and I can always run a 2.2.x kernel.  I would 
say that the stability of the kernel has been *above* my expectations, 
frankly, considering all that's changed.

It's definitely our responsibility as admins to test these kernels.  I 
was running 2.4.0-test1 the second it was released, and the one problem 
I've found has been reported and investigated (it's apparently a tough 
one).

As far as VM, I've never had the severe issues that some are reporting.  
This doesn't mean it's not a problem, but it definitely indicates that 
it's not a global showstopper.  For VM-intense applications, I roll out 
a 2.2.19 kernel as a preventative measure while I wait for the VM code 
to be tweaked.  I guess I would have expected these complaints during 
the -test phase.  Not to mention that the distributions seem to have 
rolled out 2.4.x just fine.

To wit:

box1 1 ~> uptime
  10:27am  up 168 days,  2:43,  3 users,  load average: 2.45, 2.30, 2.32
box1 2 ~> uname -a
Linux box1.mynetwork.tld 2.4.0-test6 #1 SMP Sat Aug 19 04:26:58 PDT 2000 
i686 unknown

Not true production, but totally representative of my experiences FWIW.  
IMHO, YMMV, etc.
--
Ken.

On Friday, June 1, 2001, at 10:15 AM, Miquel Colom Piza wrote:

> This is my first email to the list. I'm not subscribed but I've read it
> for years.
>
> I don't agree with those claiming that 2.4.xx is bad or still beta.
>
> We the administrators have the responsability to test early kernels and
> send  good bug reports so the developers can solve the bugs. That's the
> way we can contribute to the community.
>
> But it's really risky to use these kernels on MAIN 24x7  production
> servers.
>
> This has been true for 1.2.x  2.0.x  (I think that was the best linux
> kernel series) 2.2.x and 2.4.x and will be for 2.6.x also
>
> Given we know that the support  from open source developers is clearly
> better than commercial contract supports, I don't see the reason to
> complain about the work of those wonderfull hackers spending their spare
> time coding for all of us.
>
> (I'm not subscribed to the list, Please CC me).
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
