Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318731AbSIPCbO>; Sun, 15 Sep 2002 22:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318739AbSIPCbO>; Sun, 15 Sep 2002 22:31:14 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:29941 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S318731AbSIPCbN>; Sun, 15 Sep 2002 22:31:13 -0400
Message-Id: <200209160236.g8G2a6Qn022070@pimout3-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Pete Zaitcev <zaitcev@redhat.com>, Daniel Phillips <phillips@arcor.de>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Sun, 15 Sep 2002 17:35:59 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com> <E17qRfU-0001qz-00@starship> <20020915020739.A22101@devserv.devel.redhat.com>
In-Reply-To: <20020915020739.A22101@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 September 2002 02:07 am, Pete Zaitcev wrote:
> > From: Daniel Phillips <phillips@arcor.de>
> > Date: Sun, 15 Sep 2002 07:10:00 +0200
> >
> >[...]
> > Let's try a different show of hands: How many users would be happier if
> > they knew that kernel developers are using modern techniques to improve
> > the quality of the kernel?
>
> I do not see how using a debugger improves a quality of the kernel.

I believe we agree that you do not see it. :)

> Good thinking and coding does improve kernel quality. Debugger
> certainly does not help if someone cannot code.

And reading glasses won't help someone who can't read.  Is your above set of 
statements somehow meant to imply that a debugger cannot help someone who CAN 
code?  (Logic.  Logic is good here.)

A similar argument would be "Nobody should own an oven.  If you can't cook 
you'll just make a mess."

> A debugger can do some good things. Some people argue that it
> improves productivity, which I think may be true under some
> circomstances.

It's a tool.  Does anybody really disagree about its nature?

The main purpose of tools is to save time.  No tool is a substitute for 
skill.  it's possible to do everything a debugger can do via printks out to 
the printer and having a stack of source code printouts, and doing all your 
debugging in pencil.  It's also possible to pound in a nail with a rock, if 
you think hammers are for sissys.

If you stop and think about it, it's sort of like amish kernel development, 
isn't it?  (Hey, we've already got the community barn raising aspect.  Now 
let's outlaw certain construction techniques! :)

> If you work with something like Linux, and compile on something
> better than a 333MHz x86, it probably does not help your
> productivity.

I had the source code to the contractor-produce pile of cruft I worked with 
under OS/2.  I could even read some of it, given enough time.  Trust me, a 
source debugger REALLY helped find the differences between what it was 
supposed to be doing and what it was actually doing.  (Or more accurately, 
the few places where what it was supposed to be doing and what it was doing 
matched up...)

> This is all wonderful, but has nothing to do
> with the code quality.

I think we agree.  So why recommend against debuggers if they save time and 
effort while producing patches of equal quality?

> And to think that your users would be happier with a crap produced
> by a debugger touting Windows graduate

Sure, blame the tool. :)

> than with a quality code
> debugged with observation simply defies any reason.

So the state of the running kernel is more observablee without a kernel 
debugger than with one?

Debugging means, basically, "this sucker is doing something I didn't expect 
it to, and I have to find out what".  A debugger is a tool with which to 
examine running code.  It doesn't help you write the stuff, just examine it.  
The proper tool for the proper job...

The unix philosophy has always been to give people enough rope to shoot 
themselves in the foot with.  I'm just wondering why the exception.  (Yes I 
read the "bastard" speech.  It seemed to boil down to a crude sturgeon's law 
filter because Linus was once again being overwhelmed by crap patches (an 
annual event around here).  Making less than perfect coders code blind won't 
increase the quality of anything, but might decrease the quanity.  I suppose 
that's one way of addressing the problem, but doesn't seem to me to be an 
optimal solution...)

> -- Pete

Rob

(P.S.  Don't mind me: I have a cold.  If the above comes out as anything even 
resembling english, I'm ahead of the game...)
