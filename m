Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRADHGh>; Thu, 4 Jan 2001 02:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRADHG1>; Thu, 4 Jan 2001 02:06:27 -0500
Received: from innerfire.net ([208.181.73.33]:4618 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S129267AbRADHGQ>;
	Thu, 4 Jan 2001 02:06:16 -0500
Date: Wed, 3 Jan 2001 23:09:49 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: Dan Hollis <goemon@anime.net>
cc: Dan Aloni <karrde@callisto.yi.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.LNX.4.30.0101031657320.1616-100000@anime.net>
Message-ID: <Pine.LNX.4.10.10101032259560.5009-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Dan Hollis wrote:

> On Wed, 3 Jan 2001, Gerhard Mack wrote:
> > On Wed, 3 Jan 2001, Dan Hollis wrote:
> > > On Wed, 3 Jan 2001, Gerhard Mack wrote:
> > > > Your comparing actual security with stack guarding? Stack guarding mearly
> > > > makes the attack diffrent.. rootkits are already available to defeat it.
> > > url?
> > Ugh do you have any idea how hard it is to find 2 year old exploits?
> > Heres the best I could find on short notice:
> > http://www.insecure.org/sploits/non-executable.stack.problems.html
> > http://darwin.bio.uci.edu/~mcoogan/bugtraq/msg00335.html
> 
> You said there were rootkits specifically targetting stackguard.
> 
> These URLs simply describe attacks on stackguard, where are the
> stackguard rootkits?

I'll correct myself then: there were non exec stack patches.   Keep in
mind  part of the problem is that some compilors actually use that feature
look up "trampolines" for more info.

Also I was in error to refer to it as stack guarding.. Stack guard is a
compilor. I acually use libsafe it's preferable for 2 reasons. 
  1 It's entirely userspace and it works fine.
  2 If someone manages to render it useless I'll simply uninstall it.

	Gerhard

PS Although personally I think linux reoutation is most harmed by distribs
who insists on installing software with bad security records.  But that's
not relevent to linux-kernel.



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
