Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264916AbRFVAnw>; Thu, 21 Jun 2001 20:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbRFVAnn>; Thu, 21 Jun 2001 20:43:43 -0400
Received: from chaos.analogic.com ([204.178.40.224]:32128 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264916AbRFVAn0>; Thu, 21 Jun 2001 20:43:26 -0400
Date: Thu, 21 Jun 2001 20:43:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Anders Larsen <anders@alarsen.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <3B3291CE.7BAF5BC3@alarsen.net>
Message-ID: <Pine.LNX.3.95.1010621203455.6995A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2001, Anders Larsen wrote:

> "Richard B. Johnson" wrote:
> > 
> > QNX does not have any difference between user-space and kernel space.
> > It's not paged-virtual. It's just one big sheet of address space
> > with no memory protection (everything is shared). All procedures
> > to be executed are known at compile time.
> 
> That's completely, utterly untrue.
> QNX does indeed sport paged-virtual memory with memory protection;
> (although QNX4 does not support swap).

Then QNX is not the QNX that I have used.

> 
> User-mode interrupts are standard procedure; the deadlock problems
> Alan has mentioned do not apply, since any running process is
> always resident in memory.
> Shared regions have to be explicitly created; access is *not* open
> to anybody.
> 
> Nothing has to be known at "compile time"; QNX is a full-featured
> OS with dynamic loading.
>

The QNX that I have used, advertised as QNX, and been around since
32-bit ix86 was available, is EXACTLY as I stated.

 
> > Therefore, any piece of code can do anything it wants including
> > handling hardware directly.
> 
> Again not true; only privileged processes can enter kernel mode
> to execute port I/O instructions directly.
> 

The QNX that I have used, again is EXACTLY as stated.

> cheers
> Anders

If you have used a different QNX, then QNX has either changed
radically, or is a different company/QNX than what I used.
And, I had a lot of good experiences with it since standard
I/O was provided, as was boot, but it was an open book otherwise
in which you were not prevented from doing anything you wanted
to do, at any instant you wanted to do it.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


