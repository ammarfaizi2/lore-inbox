Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269674AbRHMBif>; Sun, 12 Aug 2001 21:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269682AbRHMBiQ>; Sun, 12 Aug 2001 21:38:16 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:11904 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S269674AbRHMBiK>; Sun, 12 Aug 2001 21:38:10 -0400
Message-ID: <3B772E5A.392C37E8@randomlogic.com>
Date: Sun, 12 Aug 2001 18:33:14 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
In-Reply-To: <20010812155520.A935@ulthar.internal.mclure.org> <Pine.LNX.4.33.0108121557060.2102-100000@penguin.transmeta.com> <20010812161544.A947@ulthar.internal.mclure.org> <200108130100.f7D10YH07664@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <3B772126.F23DB1D7@randomlogic.com> you write:
> >Call me dumb, but what was wrong with the SB Live! code in the 2.4.7
> >trees? Mine works fine and has since I first installed RH 7.1 on this
> >system. The only problem I had was when I compiled it into the kernel
> >(instead of compiling as a module), sound would not work and I could not
> >configure it with sndconfig.
> 
> Well, the fact that it didn't work when compiled into the kernel means
> (for me), that it doesn't work at all.

It is annoying not to be able to compile it as part of the kernel, but
it works as a module. I had thought that the maintainer would fix this,
but as you noted, apparently there is no longer a maintainer.

> 
> Also, if you followed the other thread on the Tyan Thunder lockup,
> you'll have noticed that it locked up under heavy PCI loads. At least on
> that machine it stopped with the 2.4.8 driver.

I hadn't read the entire thread, but I did see that heavy loads seemed
to be a problem. I am running a GeForce 3 and when I play games or do
other graphics related things - I have a few OpenGL projects I've been
working on - I try sqeak every bit of detail and piece of "eye candy" I
can out of the system, as well as the best available sound. I'd say
running Quake 3 at 1600x1200x32 in multiplayer should be a heavy load on
everything, including PCI.

> 
> Does the new driver not work for you? There seems to be a bug at close()
> time, in that the driver uses "tasklet_unlock_wait()" instead of
> "tasklet_kill()" to kill the tasklets, and that wouldn't work reliably.
> 
> Anything else you can find?
> 

I had just gotten the 2.4.7-ac10 kernel compiled and tweaked when the
2.4.8 kernel was released. I haven't had a chance to install 2.4.8 yet,
it's next on my ToDo list. Until now (reference my other post about
possible UDMA/ATA issues) I haven't been able to get a stable system for
any length of time with any kernel (save for the 5 - 6 other, older,
linux machines I have here all running RH 6.0 - 6.2).

When I get a 2.4.8 kernel installed I'll see how that works.

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
