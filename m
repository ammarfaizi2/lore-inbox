Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265861AbRFYDXA>; Sun, 24 Jun 2001 23:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265862AbRFYDWu>; Sun, 24 Jun 2001 23:22:50 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:41480 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S265861AbRFYDWd>; Sun, 24 Jun 2001 23:22:33 -0400
To: linux-kernel@vger.kernel.org
Cc: Dylan_G@bigfoot.com
Subject: Re: Annoying kernel behaviour
In-Reply-To: <9h5gbc$3mb$1@ns1.clouddancer.com>
In-Reply-To: <3B33EFC0.D9C930D5@bigfoot.com>    <9h0r6s$fe7$1@ns1.clouddancer.com>    <20010623090542.6019D7846F@mail.clouddancer.com>    <3B35C2FA.37F57964@bigfoot.com> <9h4ft5$1ku$1@ns1.clouddancer.com>    <20010624114655.3D187784C4@mail.clouddancer.com> <3B3643A8.F3FE1E92@bigfoot.com> <9h5gbc$3mb$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010625032231.930C8784C4@mail.clouddancer.com>
Date: Sun, 24 Jun 2001 20:22:31 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>Colonel wrote:
>> Ah, notice that the IRQ shifted?  Perhaps there is something else on
>> irq 10, such as the SCSI controller?  My video cards always end up on
>> that IRQ, perhaps the computer is still accessible via the network?
>
>I would expect the IRQ to shift as the system has a different
>motherboard/processor than it did in December.
>
>There are no conflicts, and PCI should be able to share anyways.

That's the theory now for some time, has never worked.  Even hacking
the SCSI driver, any attempted IRQ sharing kills my systems.  Even my
quad ethernet is not successful at sharing IRQs with itself, in 2+ very
different motherboards.


>Waht part of this do you fail to grasp?

Hehe.  The only reason you got a reply from me was that I run
video4linux with 2.4 kernels without a problem (or at least I think I
do, there are some problems but never when using xawtv).
Additionally, I've run the new RAID since the initrd period and
mingo's patches have never failed.  Any problems with RAID mentioned
on the mailing list were always traced to user error.  In short, what
you were trying to run worked fine here.

Replies afterwards were merely some guesses based on the
information you supplied.  Such as: try pulling out some hardware and
seeing if that helps.  You need to troubleshoot down to something
repeatable in order to get additional help.



-- 
"Or heck, let's just make the VM a _real_ Neural Network, that self
trains itself to the load you put on the system. Hideously complex and
evil?  Well, why not wire up that roach on the floor, eating that stale
cheese doodle. It can't do any worse job on VM that some of the VM
patches I've seen..."  -- Jason McMullan

ditto
