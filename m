Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbSKEUQw>; Tue, 5 Nov 2002 15:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265192AbSKEUQw>; Tue, 5 Nov 2002 15:16:52 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12672 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265190AbSKEUQu>; Tue, 5 Nov 2002 15:16:50 -0500
Date: Tue, 5 Nov 2002 15:23:41 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Willy Tarreau <willy@w.ods.org>, Jim Paris <jim@jtan.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
In-Reply-To: <1036526846.6750.12.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.95.1021105145542.734A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Nov 2002, Alan Cox wrote:

> On Tue, 2002-11-05 at 19:29, Richard B. Johnson wrote:
> > The only hardware a modern PC needs to use "slow-down_io" on is
> > the RTC CMOS device. Since we need to support older boards, you
> > don't want to remove the _p options indiscriminately, but you do
> > not want them ever between two consecutive writes to the same device-
> > port.
> 
> I own at least one that needs the _p on the DMA controller and at one
> that needs _p on the PIT
> 

Hey, look. I can only warn. You do what you want. As far as I'm
concerned support stopped at Linux 2.4.19 when poll got trashed.
Nobody can use 2.4.19 or probably anything later unless they have
powerful CPUs that can spin with 1000 SIGPOLL signals per second.

Like you have said, that's the nature of free software.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


