Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269308AbRGaOcE>; Tue, 31 Jul 2001 10:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269320AbRGaOb4>; Tue, 31 Jul 2001 10:31:56 -0400
Received: from web14508.mail.yahoo.com ([216.136.224.71]:37650 "HELO
	web14508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269308AbRGaObt>; Tue, 31 Jul 2001 10:31:49 -0400
Message-ID: <20010731143157.3518.qmail@web14508.mail.yahoo.com>
Date: Tue, 31 Jul 2001 07:31:57 -0700 (PDT)
From: Kent Hunt <kenthunt@yahoo.com>
Subject: Re: Longstanding sudden reboots with 2.4 smp kernels
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: lk <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10107310512100.17362-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Mark,

--- Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
wrote:
> > click some action button in the gnomeicu program.
> I am
> > ruling out hardware problems since the box is rock
> > solid except in the above mentioned situation. It
> is
> 
> that is not a valid argument.

Okay. I also don't take it as a strong evidence that
it must be a hardware problem, however, if it were a
hardware problem, then I would expect this happening
in other similar situations as well (using GUI's in
X). Now, I have more correlated data. I have tried to
use a different instant message program: licq. It also
does the same. Perhaps then the problem is using (GUI
in X with networking)? 

I had other problems in that past that many people
assured me that was a hardware problem. For example,
under high network traffic in my ppp0 the box
rebooted. There was one special condition though. The
two cpu's had to be busy with a demanding process. The
upgrade from kernel 2.2.16 to 2.4 solved completely
the problem. You may argue than that is because 2.4
might have introduced workarounds to fix buggy
hardware. Perhaps, I don't know exactly what has been
changed in the ppp code of the kernel. As a side note,
I believe this problem has been solved in the later
2.2 kernels.

For a long time I did a bunch of hardware tests to
solve the above problem. CPU burn, Memory burn, 
anything burn, watched CPU and box temperature (it was
summer time and very hot) and all tests gave negative.
This is why I also have some trust in the hardware. I
only bought good parts and I'm doing no overclocking
or other hardware tweaks that makes the box unstable. 

Each of the componets X, GUI and network I think they
work properly, I never have crashes with X, all GUI's
are working and I do a lot of heavy networking. Except
of course the IM programs.

> > frustrating since no messages are left in the
> kernel
> > logs when these reboots happen. 
> 
> there are some fault scenarios that would cause
> instant
> reboots (maybe triple faults), but of course that
> implies
> a bug making it possible (in this case, probably the
> X code).

I'm not ruling out X problem (I would be then thankful
that it is a software problem then, if someone is able
to solve). 

> equally possible is a hardware fault - being
> triggered by
> some obscure sequence doesn't mean it's not
> hardware.

I was expecting if someone could point out if there is
a clever way of isolating and detecting the problem.
The problem is that the kernel reboots, no oops or
logs. X also doesn't leave any logs. I have tried to
disable hardware pointer in X but it also doesn't
help.
Perhaps I should try to recompile gnomeicu to only
catch events and not do any networking. 

Kent


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
