Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312449AbSCYQZl>; Mon, 25 Mar 2002 11:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312453AbSCYQZb>; Mon, 25 Mar 2002 11:25:31 -0500
Received: from [195.102.192.95] ([195.102.192.95]:34543 "EHLO keston.u-net.com")
	by vger.kernel.org with ESMTP id <S312449AbSCYQZW> convert rfc822-to-8bit;
	Mon, 25 Mar 2002 11:25:22 -0500
Date: Mon, 25 Mar 2002 16:36:21 +0000
From: David Flynn <dave@woaf.net>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        jonathan@woaf.net
Subject: Re: Possible problems with D-LINK DFE-550TX (stock sundance driver) under 2.4.18
Message-ID: <20020325163621.GA21260@woaf.net>
Mail-Followup-To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
	Dave Jones <davej@suse.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
	jonathan@woaf.net
In-Reply-To: <200203250336.08428.Dieter.Nuetzel@hamburg.de> <20020325123942.A23014@suse.de> <200203251540.37393.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.27i
X-Editor: Vim http://www.vim.org/
Organisation: Poor
X-Operating-System: Linux/2.4.17 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dieter N?tzel (Dieter.Nuetzel@hamburg.de) wrote:
> On Montag, 25. März 2002 :39, Dave Jones wrote:
> > On Mon, Mar 25, 2002 at 03:36:07AM +0100, Dieter Nützel wrote:
> >  > > Try booting with just one processor (maxcpus=1 boot option) or borrow
> >  > > two Athlon MP and see if you can reproduce the problem then. If you
> >  > > can, someone may help you. I you can't reproduce it with one CPU,
> >  > > you're probably on your own.
> >  >
> >  > On "newer" Athlon XP (Duron, Athlon Thoroughbred) L5-4 bridge have to be
> >  > closed.
> >
> > You don't for a minute think that there might be a reason that bridge
> > got broken at the factory ? *sigh*, we've been through this topic
> > before, I'm tired of arguing it.
> 
> Sure, but some wise men said, "there is nothing that simple on this planet".
> Some Athlon XP/MP are "broken", so they were labeled as XPs.
> In the other case it's simple marketing and business (earning more money).
> You can only argue about the distribution. But your are right, I won't do 
> that. I only want to be sure that David didn't have one of the old XPs.
> 
> -Dieter
>

Please, do we have to go on about the merits of Athlon XP systems in MP
configurations ?? 1) your wrong about the bridges, it only affects iirc
the new XP2000+ chips, 2) is it /REALLY/ the issue ?? i do not think so.

However, I am very happy to report that the system has just done it
again.  I can't give any further details yet, although i am just going
over to pay a visit to the box and do some more investigations.

FYI, we have two of these boxes with the same hardware / kernel
configuration.  Two of them have now shown the same problem (eth0
timeouts).  Including having maxcpus=1 set.

Could this perhaps be a driver issue after all ?

Many Thanks

Dave
