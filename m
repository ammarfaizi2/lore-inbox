Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279019AbRJVWaW>; Mon, 22 Oct 2001 18:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279015AbRJVW21>; Mon, 22 Oct 2001 18:28:27 -0400
Received: from 87-VALL-X11.libre.retevision.es ([62.83.209.87]:34564 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S279008AbRJVW17>; Mon, 22 Oct 2001 18:27:59 -0400
Date: Mon, 22 Oct 2001 02:24:42 +0200
From: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
To: Abraham vd Merwe <abraham@2d3d.co.za>, Tim Jansen <tim@tjansen.de>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: LPP (was: The new X-Kernel !)
Message-ID: <20011022022442.A467@ragnar-hojland.com>
In-Reply-To: <20011021220346.D19390@vega.digitel2002.hu> <15vQtM-22TOdsC@fmrl02.sul.t-online.com> <20011022022839.A8452@unthought.net> <15va3i-0cRXvcC@fmrl00.sul.t-online.com> <20011022103411.A17996@crystal.2d3d.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011022103411.A17996@crystal.2d3d.co.za>; from abraham@2d3d.co.za on Mon, Oct 22, 2001 at 10:34:11AM +0200
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 10:34:11AM +0200, Abraham vd Merwe wrote:
> > 
> > Because the majority of people (and especially those who haven't been reac
> > by Linux yet) don't care for the messages. They are as interested in boot
> > messages as you may be in reading debug information from your DVD player o
> > car. 

Even better paralelism:  What do people run, strace ls or ls?

> Interesting you should mention this analogy. Incidently, I would've
> preferred that my car give me a detail analysis of what's wrong. In fact,

Please reread what you have written.  Now run dmesg.  Do you see messages
telling you what's wrong there?  No?  Okay.. So what is it telling you?

Details about your system?   No, thats *how* it is telling you.  What aaall
those lines are saying is that everything is working as usual. Wait wait,
don't jump yet :)

Okay.  They do help to debug early kernel crashes, showing exactly where it
stopped.  With no messages, an literate user would use 'boot_verbose=1' to
override the 'boot_verbose=0' in lilo.conf and see where it crashed.  

Now picture a quite iliterate user with a messages, and a boot problem..
what will he say in the majority of the cases?  I'll tell you: "my linux 
wont boot" / "my linux crashed", and if you ask what was on the screen to 
"oh.. dunno.. the lines it uses to print..", so messages wouldnt make a
difference.  If people dont use to read error/message dialogs, are you
seriously expecting them to read and understand that "text thingie"?

> confusing it with is that this O/S was (and still is) written and being
> maintained by technical people. These kind of people like to know what's
> going on. It also happens that the primary audience for these people's work
> is themselves (us) and NOT novices - that my friend, is a bonus, not the

I disagree with your reasoning.  You give two points.. first, that technical
people want to know whats going on.  They do.  They would.  In fact, nobody
is saying the "raw" kernel (ie without args) shouldn't show the messages.

And primary audience.  Well.  People don't get educated out of the blue.
You need to soften (even more, yes) the learning curve.  What would you
consider more pleasant, an OS in which you can dive bit by bit, or one that
just drops you there and requires you to read a lot of stuff?  I am quite
concerned about about the people who say they want to try linux, but that
its too hard for them.

Someone said in this thread that you write for idiots you get idiots, wrt
hiding boot messages.  I don't read them when I boot, so they are,
effectively, hidden.  Does that make me an idiot?

Idiocy has nothing to do with simplicity.  And we know simplicity is good.

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."
