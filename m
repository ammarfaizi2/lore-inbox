Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264588AbRFTTz6>; Wed, 20 Jun 2001 15:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264589AbRFTTzj>; Wed, 20 Jun 2001 15:55:39 -0400
Received: from [195.63.194.11] ([195.63.194.11]:7699 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S264588AbRFTTz3>;
	Wed, 20 Jun 2001 15:55:29 -0400
Message-ID: <3B30FF33.58807C3F@evision-ventures.com>
Date: Wed, 20 Jun 2001 21:53:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Mike Harrold <mharrold@cas.org>
CC: landley@webofficenow.com, linux-kernel@vger.kernel.org
Subject: Re: [OT] Threads, inelegance, and Java
In-Reply-To: <200106201927.PAA01484@mah21awu.cas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Harrold wrote:
> So what? Crusoe isn't designed for use in supercomputers. It's designed
> for use in laptops where the user is running an email reader, a web
> browser, a word processor, and where the user couldn't give a cr*p about
> performance as long as it isn't noticeable (20% *isn't* for those types
> of apps), but where the user does give a cr*p about how long his or her
> battery lasts (ie, the entire business day, and not running out of power
> at lunch time).

I'm just to good in remembering the academing discussion about
code morphing beeing a way to get more performance out of a chip
design. They where claiming, that due to the fact they could make
the underlying chip design much simpler and VLIW, the performance offset
by the emulation wouldn't be smaller than the performance win
in therms of a suprerior underlying chip architecture.
This was set off to provide compensation for the biggest hurdle
of VLIW design - insane code size and partially huge memmory
bus bandwidth designs due to this. (Why do you think the itanim
sucks on integer performance?)
After this turned out the be the fact in reality - IBM dropped
the developement of code morphing chips. Well transmeta turned
to claims that the main advantage of it's design is much smaller
power consumption. Well but in relity underclocked modern
design optimized for power consumtions beat the transmeta
chip easly: Geode, and the recently announced VIA chip to name a few.
In comparision to chip design esp. targetted at low power consumtion
the transmeta chip is laughable: this ARM please! My psion
beats *ANY* chip from them by huge magnitude.

> Yes, it *can* be used in a supercomputer (or more preferably, a cluster
> of Linux machines), or even as a server where performance isn't the
> number one concern and things like power usage (read: anywhere in
> California right now ;-) ), and rack size are important. You can always
> get faster, more efficient hardware, but you'll pay for it.

Well the transmeta cpu isn't cheap actually. And if you talk about
super computing, hmm what about some PowerPC CPU variant - they very
compettetiv in terms of cost and FPU performance! Transmeta isn't the
adequate choice here.

> Remember, the whole concept of code-morphing is that the majority of
> apps that people run repeat the same slice of code over and over (eg,
> a word processor). Once crusoe has translated it once, it doesn't need
> to do it again. It's the same concept as a JIT java compiler.

Well both of those concepts fail in terms of optimization due
to the same reason: much less information is present about
the structure of the code then during source code compilation.
And therefore usually the performance of any kind of JIT compiler
*sucks* in comparision to classical sophisticated compilers.
Additionaly there may be some performance wins due to the
ability of runtime profiling (anykind thereof), however it still remains
to be shown that this performs better then statically analyzed code.

> /Mike - who doesn't work for Transmeta, in case anyone was wondering... :-)

/Marcin - who doesn't bet a penny on Transmeta
