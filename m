Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263422AbRFEXkL>; Tue, 5 Jun 2001 19:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263423AbRFEXkC>; Tue, 5 Jun 2001 19:40:02 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:52180 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S263422AbRFEXjs>; Tue, 5 Jun 2001 19:39:48 -0400
Date: Tue, 5 Jun 2001 16:38:06 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: Derek Glidden <dglidden@illusionary.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
Message-ID: <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Jun 2001, Derek Glidden wrote:

>
> After reading the messages to this list for the last couple of weeks and
> playing around on my machine, I'm convinced that the VM system in 2.4 is
> still severely broken.
>
> This isn't trying to test extreme low-memory pressure, just how the
> system handles recovering from going somewhat into swap, which is a real
> day-to-day problem for me, because I often run a couple of apps that
> most of the time live in RAM, but during heavy computation runs, can go
> a couple hundred megs into swap for a few minutes at a time.  Whenever
> that happens, my machine always starts acting up afterwards, so I
> started investigating and found some really strange stuff going on.

I reboot each of my machines every week, to take them offline for
intrusion detection.  I use 2.4 because I need advanced features of
iptables that ipchains lacks.  Because the 2.4 VM is so broken, and
because my machines are frequently deeply swapped, they can sometimes take
over 30 minutes to shutdown.  They hang of course when the shutdown rc
script turns off the swap.  The first few times this happened I assumed
they were dead.

So, unlike what certain people like to repeatedly claim, the 2.4 VM
problems are causing havoc in the real world.

-jwb

