Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278265AbRJWUt4>; Tue, 23 Oct 2001 16:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278266AbRJWUtj>; Tue, 23 Oct 2001 16:49:39 -0400
Received: from pasky.ji.cz ([62.44.12.54]:4855 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S278265AbRJWUta>;
	Tue, 23 Oct 2001 16:49:30 -0400
Date: Tue, 23 Oct 2001 22:50:03 +0200
From: Petr Baudis <pasky@pasky.ji.cz>
To: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
Cc: Abraham vd Merwe <abraham@2d3d.co.za>, Tim Jansen <tim@tjansen.de>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: LPP (was: The new X-Kernel !)
Message-ID: <20011023225003.E14850@pasky.ji.cz>
Mail-Followup-To: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>,
	Abraham vd Merwe <abraham@2d3d.co.za>, Tim Jansen <tim@tjansen.de>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20011021220346.D19390@vega.digitel2002.hu> <15vQtM-22TOdsC@fmrl02.sul.t-online.com> <20011022022839.A8452@unthought.net> <15va3i-0cRXvcC@fmrl00.sul.t-online.com> <20011022103411.A17996@crystal.2d3d.co.za> <20011022022442.A467@ragnar-hojland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011022022442.A467@ragnar-hojland.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Even better paralelism:  What do people run, strace ls or ls?
With strace ls, output of ls is not very usable. So this doesn't match.

> > Interesting you should mention this analogy. Incidently, I would've
> > preferred that my car give me a detail analysis of what's wrong. In fact,
> 
> Please reread what you have written.  Now run dmesg.  Do you see messages
> telling you what's wrong there?  No?  Okay.. So what is it telling you?
With hiding of messages during boot, you won't ever have an idea to _run_
the dmesg!

> Okay.  They do help to debug early kernel crashes, showing exactly where it
> stopped.  With no messages, an literate user would use 'boot_verbose=1' to
> override the 'boot_verbose=0' in lilo.conf and see where it crashed.  
They can also help to presume problems on the horizon and then seeking for
the cause of them... one might say... ah, wait a minute, now i remember,
during bootup i glanced there, and there was something about DMA errors,
wtf is that? can't it be a problem?

> Now picture a quite iliterate user with a messages, and a boot problem..
> what will he say in the majority of the cases?  I'll tell you: "my linux 
> wont boot" / "my linux crashed", and if you ask what was on the screen to 
> "oh.. dunno.. the lines it uses to print..", so messages wouldnt make a
> difference.  If people dont use to read error/message dialogs, are you
> seriously expecting them to read and understand that "text thingie"?
and when they hide them, they will say "it didn't do anything. dunno where
it stopped. to run it with li..what? loot_virboss:zero? excuse me?"

> Someone said in this thread that you write for idiots you get idiots, wrt
> hiding boot messages.  I don't read them when I boot, so they are,
> effectively, hidden.  Does that make me an idiot?
if you want to force one not to see them even if he might want once time,
but dunno how to turn them on...

> Idiocy has nothing to do with simplicity.  And we know simplicity is good.
debug messages don't add complexity. optionality of them does. :P

as someone said here, this is also a psychological issue, the feeling of
common secret knowledge, the feeling of speciality, the cool matrix-like
look which make you look as geek and expert, the mysterious messages which
will actually tell you everything what that thing does, does it matter
that you don't understand it? it looks cool so it is good :P and you said
they won't even read it, so they won't have a feeling of informations
overhead, so they won't hate or fear the computer, just like it that it
is willing to tell them what is going on, if they would ever want to listen...

-- 

				Petr "Pasky" Baudis

UN*X programmer, UN*X administrator, hobbies = IPv6, IRC
Real Users hate Real Programmers.
Public PGP key, geekcode and stuff: http://pasky.ji.cz/~pasky/
