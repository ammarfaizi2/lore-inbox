Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292847AbSCJIhN>; Sun, 10 Mar 2002 03:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292915AbSCJIhE>; Sun, 10 Mar 2002 03:37:04 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:36369 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S292847AbSCJIgz>; Sun, 10 Mar 2002 03:36:55 -0500
Message-ID: <3C8B1B25.7000208@namesys.com>
Date: Sun, 10 Mar 2002 11:36:53 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home> <20020207132558.D27932@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>
>
>Before you yell at me, remember that source management is not the same
>as the kernel.  Everyone has to use the kernel, the computer doesn't work
>without it.  Take that set of people and remove everyone who doesn't use
>source management.  Out of a potential space of billions of people, you
>are left with a market of about .5 - 2 million, world wide.  And there
>are 300 SCM systems fighting over that space.  The top 3 have 50% of the
>space.  So 297 systems fighting over maybe a million users.  That's 3300
>users per system.  OK, so if each of those people were willing to pay
>$500 for arch support/whatever, that's a total of 1.6 million dollars.
>Which isn't remotely close enough to get the job done.  And don't forget
>that those people have to volunteer that money, it can't be pried out
>of them.
>
>It's just math.  Projects that aren't universally used have a much harder
>time getting funding than projects that everyone uses.  It doesn't matter
>what the value is to you, it matters what the costs are to the developers.
>This is why microsoft is so rich, they build apps that the masses use.
>It's also why clearcase+clearquest is $8000/seat.  It's not because
>that's what the value is, it's because that's what the cost has to be
>or Rational starts to die.
>
>So before you start talking about support contracts, and grants, and
>whatever, realize that the pool of people interested in paying those
>dollars is very small.  Are _you_ going to send Tom $500?
>
This is why version control has to go into a standard filesystem as a 
standard filesystem feature that every user uses.  When version control 
costs $8k per seat, only a tiny few can afford it.  I sure can't, and I 
am a professional programmer.  Version control has to become just 
another expected filesystem feature, and one that is so transparent to 
users that Mom uses it without fear.  Reiser4 will have transactions 
built-in, and the natural technical progression from there is version 
control and branching.  I want to see the number of version control 
users equal to 90% of the number of ReiserFS users in three years (not 
Linux 2.6 but Linux 2.8 or later).  If that happens, then open source 
can economically support the core version control features, and $8k 
pay-for-use plugin suites and utilities from folks like Larry can supply 
those expensive to write tweaks that wealthy software management types 
want.  

I think that if version control becomes as simple as turning on a plugin 
for a directory or file, and then adding a little to the end of a 
filename to see and list the old versions, Mom can use it.

Besides, version control is useful for distributed filesystem designs 
(high-performance distributed parallel writes work better with version 
control in use.)

That said, Larry, a big thanks for making Bitkeeper free for use, an 
even bigger thanks for getting Linus to use it, and I hope you get at 
least a fraction of the money that you deserve from selling Bitkeeper.
Now I just have to finish shoving it down my developer's throats....:-/ 
 Version control system adoption is always a lot of effort for 
management, and CVS was an enormous hassle to get them to use also....

Hans


