Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279858AbRKRPa7>; Sun, 18 Nov 2001 10:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279842AbRKRPau>; Sun, 18 Nov 2001 10:30:50 -0500
Received: from ns.suse.de ([213.95.15.193]:59153 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279858AbRKRPag>;
	Sun, 18 Nov 2001 10:30:36 -0500
Date: Sun, 18 Nov 2001 16:30:27 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] moving F0 0F bug check to bugs.h
In-Reply-To: <Pine.LNX.4.33.0111181709580.16977-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.30.0111181626290.29315-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, Zwane Mwaikambo wrote:

> Indeed the whole setup.c is a bit confusing, a cpusetup.c file or somesuch
> would make things a bit simpler with maybe an exported function to setup.c
> in the nature of cpu_detect(...). In your 2.5 todo, are you going
> to move the errata/bugs to the same cpusetup file or a seperate one?

The thing is, some identification code needs errata workarounds to happen
(such as the cache sizing code for eg). There comes a point where
splitting stuff up into lots of little files goes too far and becomes
a hindrance rather than a benefit.

When the slicing & dicing happens, I'll take a look at the sizes of
the bits, and see if it's worthwhile.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

