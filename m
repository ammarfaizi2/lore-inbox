Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbRGFR4d>; Fri, 6 Jul 2001 13:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266776AbRGFR4O>; Fri, 6 Jul 2001 13:56:14 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:54092 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S266774AbRGFR4G>; Fri, 6 Jul 2001 13:56:06 -0400
Subject: Re: >128 MB RAM stability problems (again)
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Peter "A." Castro <doctor@fruitbat.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0107051219080.4734-100000@gremlin.fruitbat.org>
In-Reply-To: <Pine.LNX.4.21.0107051219080.4734-100000@gremlin.fruitbat.org>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 06 Jul 2001 19:55:50 +0200
Message-Id: <994442162.1047.0.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 05 Jul 2001 13:45:23 -0700, Peter A. Castro wrote:
> Each OS allocates the physical memory differently.  MS-Windows typically
> allocates physical memory sequentually.  Linux tends to uses both ends of
> the memory pool.  For a proper test, you need to load enough programs so
> that all of physical memory will be utilized.  Win2k may be "stable"
> because you aren't loading enough of the system to touch the second bank
> of memory.  Please try running several large programs and exercise them
> all together for several minutes.  You can use the task manager to find
> the total memory used on the system. 

Pheew (this is sarcastic)
You're fully correct, after toying a bit on win2k, I crashed it a few
times with weird errors and I must say, these blue screens in win2k look
a *lot* better than the ones I used to see in win98 ;-). They still
don't match that wonderful "kernel panic", though.

So, basically, my bios must have loaded the wrong options for my memory
which must run above it's limits which causes data corruption... Then,
my stupid question, why doesn't memtest86 detect that?

Anyway, I'll go look at the bios settings of the computers, look at the
CAS/RAS/clock timing settings like two people suggested (thanks :-) )
and hope to be happy and have a stable machine after that.

Thanks for this half-solution :-)

--
Ronald Bultje

