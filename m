Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131350AbQLUWMr>; Thu, 21 Dec 2000 17:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131464AbQLUWM2>; Thu, 21 Dec 2000 17:12:28 -0500
Received: from [203.36.158.121] ([203.36.158.121]:32131 "HELO kabuki.eyep.net")
	by vger.kernel.org with SMTP id <S131241AbQLUWMV>;
	Thu, 21 Dec 2000 17:12:21 -0500
To: safemode <safemode@voicenet.com>
cc: Zdenek Kabelac <kabi@fi.muni.cz>, xOr <xor@x-o-r.net>,
        linux-kernel@vger.kernel.org
Subject: Re: lockups from heavy IDE/CD-ROM usage 
In-Reply-To: Your message of "Thu, 21 Dec 2000 15:00:16 CDT."
             <3A426150.1545FC96@voicenet.com> 
In-Reply-To: <Pine.LNX.4.31.0012210421450.284-100000@bitch.x-o-r.net> <3A41FFD8.531DF534@fi.muni.cz>  <3A426150.1545FC96@voicenet.com> 
Date: Fri, 22 Dec 2000 08:44:02 +1100
From: Daniel Stone <daniel@kabuki.eyep.net>
Message-Id: <20001221221226Z131241-440+3492@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get this on the 440LX with the same DMA timeout message.  Everyone says it's
> the board's fault as well.  Funny.   Anyways this happens accross just about
> any Dev kernel but more so in the -test12 and up versions. .   Test10 works
> fine without locking.  Blaming the hardware reminds me of the help given by
> some other company I can't seem to remember the name to.

Well, think about it - if there are DMA/IRQ timeouts, the hardware IS rooted.
Otherwise, why would it be timing out? I've been seeing these messages
shortly before a hardlock (except for the fact numlock still works, but
nothing else) when doing long, intensive hard drive activity. Because my
hard drives are right next to each other, overheat sometimes and shut
straight down when they do. But I'm gonna take a wild guess it's not Linux's
fault, unless they've done some whacky stuff with the elevator ;)

--
Daniel Stone
Linux Kernel Developer
daniel@kabuki.eyep.net

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
G!>CS d s++:- a---- C++ ULS++++$>B P---- L+++>++++ E+(joe)>+++ W++ N->++ !o
K? w++(--) O---- M- V-- PS+++ PE- Y PGP>++ t--- 5-- X- R- tv-(!) b+++ DI+++ 
D+ G e->++ h!(+) r+(%) y? UF++
------END GEEK CODE BLOCK------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
