Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312134AbSC2Vcf>; Fri, 29 Mar 2002 16:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312119AbSC2Vc0>; Fri, 29 Mar 2002 16:32:26 -0500
Received: from wotug.org ([194.106.52.201]:64266 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S312104AbSC2VcN>;
	Fri, 29 Mar 2002 16:32:13 -0500
Message-Id: <5.1.0.14.0.20020329210605.00b5ded8@mailhost.ivimey.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 29 Mar 2002 21:26:17 +0000
To: Mark Hahn <hahn@physics.mcmaster.ca>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: Re: Request for 2.4.20 to be a non-trivial-bugfixes-only 
  version
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <Pine.LNX.4.33.0203291601040.3565-100000@coffee.psychology.
 mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:06 29/03/2002 -0500, you wrote:
>sure; every delta is critical for someone.  but why do you think
>stability comes from slowing or refusing deltas?  or perhaps you're
>just saying that you want to see a longer testing interval?

if delta == fix for an identified bug, then refusing them is obviously bad, 
assuming the bugfix is itself ok

if delta == some (random) change someone thought would be nice, then 
stability is not normally improved by adding them

I'm not sure what 'testing interval' you refer to?

>personally, I think there should be alpha (linus), beta (marcello)
>and gamma (maybe alan) streams, since some people really do seem
>to think marcello is moving too fast (he's way to slow for me.).
>or maybe it should be l-ac-m (well, it pretty much is, though I don't
>believe there's any formal analysis of how well-tested a delta is
>in ac's tree.)

I was under the impression that a 2.2.x/2.4.x2.6.x kernel was changed on 
the premise that stability and correctness had high priority, and that 
2.3.x/2.5.x/2.4.7.x were built on the premise that introducing new 
features, optimizing and restructuring code, and addressing weaknesses had 
high priority.

I guess, though, if someone said : 2.4.x is feature-complete: you can 
_only_ fix bugs in it, then we'd have a revolt :-)   So perhaps you're 
right, and we need three paths:

  - a 2.5-like path, where anything sensible goes
  - a 2.4-like path, where a lot goes, but nothing too big :-)
  - a new path, where stability is paramount.

Of course, you could say 'why don't I use 2.2.20, if I'm that worried'. 
Well, 2.4. has a bunch of features (e.g. iptables, decent USB & ATM 
support, ) that I need or want badly enough that I'm prepared to put up 
with some hassle. So currently I'm trying to find a kernel that is good 
enough to leave alone. 2.4.18-rc1 is pretty good so far, but looking 
through the patches btw. rc1 and final, and .19, I wonder which of the 
fixed bugs I might hit next. Problem is, I have been looking for the 'good' 
kernel for a while: trying 2.4.6, 2.4.8, 2.4.15, 2.4.17, 2.4.18rc1 -- I'm 
starting to wonder when it might get here.

>finally, noone has enough time for as much testing as they should do.
>more trees just make this worse.  if you're concerned about the stability
>of the stable branch, are you doing something to improve testing?

I try. I don't have a huge amount of time, but I'm using 2.4.18-rc1 on a 
gateway box that is ADSL connected through a USB SpeedTouch; sometimes, the 
ADSL IP link *just dies*; I am running with lots of logging to find out 
more, and am slowly looking through the sources by hand to try to find 
problems 'in my head'. It is hard going, and not any easier for the 
SpeedTouch firmware being closed.

Anyway, enough!

Ruth

