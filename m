Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262438AbTCMPBg>; Thu, 13 Mar 2003 10:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262441AbTCMPBg>; Thu, 13 Mar 2003 10:01:36 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7809 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262438AbTCMPBf>; Thu, 13 Mar 2003 10:01:35 -0500
Date: Thu, 13 Mar 2003 10:13:49 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: James Stevenson <james@stev.org>, pd dd <parviz_kernel@yahoo.com>,
       "M. Soltysiak" <msoltysiak@hotmail.com>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
Subject: Re: Linux BUG: Memory Leak
In-Reply-To: <20030313151047.GA20516@mark.mielke.cc>
Message-ID: <Pine.LNX.3.95.1030313100813.21600A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003, Mark Mielke wrote:

> On Thu, Mar 13, 2003 at 09:42:39AM -0500, Richard B. Johnson wrote:
> > But it's a memory leak in the game, not the kernel. They should
> > complain to the game makers. If a game runs the system out of
> > memory so a user can't log in on the root account and kill off
> > the game, it's a problem with the game.
> 
> I would like to encourage the camp of people who believe that UNIX can
> be a stable server platform to innovate ways of ensuring that if a game
> (or other memory intensive program) does run the system out of memory,
> an administrator could login as root and kill the game.
> 
> So I don't agree with your conclusion. I think "your system crashed? well
> contact the application designer..." is a mindset that was strongly
> encoduraged by companies such as Microsoft, as it allowed them to release
> half baked kernels and call them stable. Thankfully, even Microsoft has
> learned that this isn't the best approach, and WinXP is quite a deal more
> solid than Win95.
> 
> Yes, Linux is the result of (mostly) volunteer effort contributed to the
> community. No, I don't think that means it is acceptable for it to contain
> security exploits, or for it to be any less robust than other operating
> systems in its class such as AIX or Solaris. We have smart people. Let's
> use them. Let's not be satisfied with less.
> 
> mark

For the most part we are getting people who don't know about
CTL-ALT-BACKSPACE, and have never even seen a shell, and don't
know that the GUI is not the normal interface, complaining because
the machine "locks" after they play some lossy games. You don't
have to reboot, you need to restart the X-Server (that will kill off
the memory-hogging games). Most distributions don't even configure
to allow the X-Server to be restarted. Still, it's not a kernel
problem and it can't be "fixed" or "worked around" in the kernel.
When you hang the user inteface, you can interface with users.
It's really that simple.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


