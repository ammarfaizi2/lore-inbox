Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVCCCUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVCCCUw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVCCCSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:18:20 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:12966 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261395AbVCCCOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:14:22 -0500
Date: Wed, 02 Mar 2005 21:14:20 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: RFD: Kernel release numbering
In-reply-to: <20050302165830.0a74b85c.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503022114.20214.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
 <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 19:58, David S. Miller wrote:
>On Wed, 02 Mar 2005 19:29:35 -0500
>
>Jeff Garzik <jgarzik@pobox.com> wrote:
>
>The problem is people don't test until 2.6.whatever-final goes out.
>Nothing will change that.

Except more people who think like me.  I usually enjoy playing the 
canary, else I wouldn't do it.

More Canaries I say.  I build, and run till the next rc comes out 
almost every rc & I'm curently up on 2.6.11 for 5h:30m.  I've only 
got this one box thats fast enough to do that and still get anything 
else done too, so this is the workhorse.  I don't yelp about 
deprecation notices during the build, I figure you people have eyes 
too.

Basicly on my limited variety of hardware, I at least can play the 
part of the canary here, and have a couple of times when problems 
show up in less than a couple of days or during the build itself.

What you really need is a stronger plea for more people to go beat on 
the rc releases, but I fear thats never going to happen as long as 
there is nothing but the rc stuffs, and no -pre stuff for testing the 
-mm stuff a little wider.  Back in 2.4 days, even the -pre stuff was 
often stable enough for extended uptimes, and I mean that I ran

May  1  2003 vmlinuz-2.4.21-pre7 on that 7.3 box until Jan 21 2005.

Its now got a 2.4.29 final on it and:
 8:56pm  up 23 days,  8:00,  6 users,  load average: 2.12, 1.40, 1.14
 sailing along just as smoothly as ever since Feb 7.

Not without a reboot over that nearly 2 years of course, but the 
choice of when to do the reboot was mine in every case.  Here on this 
box, trying to play canary, uptimes are often less than a week, 
sometimes less than 24 hours, and that isn't anywhere near long 
enough to be able to say 'its stable'.  Stuff is IMO, being shoved 
out without an adequate amount of time to see what the 'canary' does.

If we could only get more people to 'bang on it, kick the tires etc', 
AND fix those sorts of problems that do show up in the next 
sequential rc, a lot of stuff like 2.6.8 could be headed off.
Note the caps on the word AND.  That bugfix in the next rc release 
seems to be broken when obviously needed fixes often have to go back 
to the head of the queue and work their way back to Linus.

So how DO you go about getting the tires kicked by more users?  I'm 
not sure what would work.

One doesn't have to be a code monkey to do this 'canary' scene as long 
as a bash script can be hacked up to do the majority of the work, I 
have a couple of them that basicly make a new kernel install a no 
brainer.  Often under 30 minutes to being rebooted to a new rc from 
going after the patch.

And I ramble, but this is my $0.02.  And probably about what its worth 
in the Grande Scheme of Things...

>And the day Linus releases we always get a pile of "missing
> MODULE_EXPORT()" type bug reports that are one liner fixes.  Those
> fixes will not be seen by users until the next 2.6.x rev comes out
> and right now that takes months which is rediculious for such
> simple fixes.

I agree.  Ditto for the 1394 fixes that have been upstream for at 
least a month, maybe more.  I haven't checked to see if kino can run 
my movie camera yet, if it can, then maybe it made it into 2.6.11.  
Otherwise I'll have to go nuke that dir in the drivers tree, and 
again grab the svn from the 1394 site and rebuild/reinstall.  
Provided the svn server is up, thats not a big deal here.  The point 
is that it is being tested, and it does work.

>We're talking about a one week "calming" period to collect the brown
> paper bag fixes for a 2.6.${even} release, that's all.
>
>All this "I have to hold onto my backlog longer, WAHHH!" arguments
> are bogus IMHO.  We're using a week of quiescence to fix the tree
> for users so they are happy whilst we work on the 2.6.${odd}
> interesting stuff :-)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
