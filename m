Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265598AbTF3CWL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 22:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265599AbTF3CWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 22:22:11 -0400
Received: from franka.aracnet.com ([216.99.193.44]:6063 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265598AbTF3CVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 22:21:55 -0400
Date: Sun, 29 Jun 2003 19:35:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk
cc: greearb@candelatech.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <17280000.1056940541@[10.10.2.4]>
In-Reply-To: <20030629.151302.28804993.davem@redhat.com>
References: <1056755070.5463.12.camel@dhcp22.swansea.linux.org.uk><20030629.141528.74734144.davem@redhat.com><1056924426.16255.24.camel@dhcp22.swansea.linux.org.uk> <20030629.151302.28804993.davem@redhat.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--"David S. Miller" <davem@redhat.com> wrote (on Sunday, June 29, 2003 15:13:02 -0700):

>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 29 Jun 2003 23:07:07 +0100
>    
>    What you don't get is that like you I'm distributing work. I'm
>    getting end users to spot bug correlations - and thats why I want
>    better tools
>
> DaveM:
> I understand this part, it's great sounding in theory.
> 
> But all the examples I've seen are you sifting through bugzilla making
> these correlations.  I've seen no evidence of community participation
> in this activity.

People have been. Maybe not with the networking bugs, but I've seen
people sift through other stuff, and mark off duplicates, and point
out similarities. People go chase attatched patches back into the tree,
and people test fixes they didn't submit the bug for, and report status.
I'd like more of that, but it happens already.
 
> The greatest tools in the world aren't useful if people don't want
> to use them.
> 
> Nobody wants to use tools unless it melds easily into their existing
> daily routine.  This means it must be email based and it must somehow
> work via the existing mailing lists.  It sounds a lot like what I'm
> advocating except that there's some robot monitoring the list
> postings.

Agreed, the interface could be better - we're working on it. It won't
be totally change free, but it could be better integrated. Feedback is
very useful, though it helps a lot of you can pinpoint what's the 
underlying issue rather than "this is crap". Better email integration
is top of the list, starting with sending stuff out to multiple people
when filed, not a single bottleneck point.
 
> But then who monitors and maintains the entries?  That's the big
> problem and I haven't heard a good solution yet.  Going to a web site
> and clicking buttons is not a solution.  That's a waste of time.

There is an army of elves out there, quite capable and willing.
Like most change, it takes a little time, but it's started already.

> AEB:
>
> See, you think you are doing the submitter a favour.
> I prefer the point of view that the submitter does us a favour.
 
Absolutely. Personally, I think testing & communication with users is 
more what we're lacking as a community than coding power. In Dave's 
case, it sounds like he's so swamped, it's not an issue for him. 

However, finding and fixing stuff earlier on will actually reduce
the workload, IMHO. It's a damned sight easier to find a bug you wrote
yesterday than one you wrote last year. I *love* things like nightly
regression testing that reaches out and larts me with a bug report
in < 24 hrs of me screwing things up.

Lastly, I'd rather ditch bug reports based on crap content, or overall
impact, than whether I happened to be busy at the moment they came in.

M.
