Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262382AbTCRNvi>; Tue, 18 Mar 2003 08:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262399AbTCRNvh>; Tue, 18 Mar 2003 08:51:37 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3206 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262382AbTCRNvg>; Tue, 18 Mar 2003 08:51:36 -0500
Date: Tue, 18 Mar 2003 09:03:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Mehmet Ersan TOPALOGLU <mersan@ceng.metu.edu.tr>
cc: linux-kernel@vger.kernel.org
Subject: Re: process resident in memory
In-Reply-To: <3E772604.5050604@ceng.metu.edu.tr>
Message-ID: <Pine.LNX.4.53.0303180901001.26924@chaos>
References: <3E76BCA9.3060902@ceng.metu.edu.tr> <20030318134238.GA22953@riesen-pc.gr05.synopsys.com>
 <3E772604.5050604@ceng.metu.edu.tr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003, Mehmet Ersan TOPALOGLU wrote:

> Alex Riesen wrote:
> > Mehmet Ersan TOPALOGLU, Tue, Mar 18, 2003 07:28:57 +0100:
> >
> >>I am a newbie in kernel programming.
> >>And am sorry if something related previously asked.
> >>I wonder if it is possible to following situation is possible or not.
> >>
> >>let say i have a user process p1.
> >
> >
> > That (user process) has nothing to do with kernel programming.
> >
> >
> >>p1 does some malloc, and file i/o etc
> >>i initiate it during boot time.
> >>it stays resident in memory as if kernel it self (??)
> >
> >
> > no. It is as long resident as it wish. Or until it is killed.
> >
> >
> >>and its priority is very very high
> >
> >
> > it is irrelevant.
> >

Yes, but he didn't know what was available in user-mode.


>
> Well i guess i couldn't explain what i really meant.
> Thing is that i am trying to change kernel memory management
> specifically for one user process only.
> i.e if kernel sees this process it will treat it in a different manner.
> It won't let it to be swapped and give a very high priority to it.
> I just wondered the possiblity of this.
> Sorry for my poor english
>

You want to execute:

man mlockall
man nice


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

