Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbSJCQVJ>; Thu, 3 Oct 2002 12:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSJCQVI>; Thu, 3 Oct 2002 12:21:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7315 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261442AbSJCQVG>;
	Thu, 3 Oct 2002 12:21:06 -0400
Date: Thu, 3 Oct 2002 09:28:33 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: john stultz <johnstul@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       george anzinger <george@mvista.com>
Subject: Re: [PATCH] linux-2.5.40_timer-changes_A3 (1/3 - infrastructure)
In-Reply-To: <1033625380.28783.60.camel@cog>
Message-ID: <Pine.LNX.4.44.0210030922210.27710-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	Inspired by suggestions from Alan, this collection of patches tries to
> clean up time.c by breaking out the PIT and TSC specific parts into
> their own files. Additionally the patch creates an abstract interface to
> use these existing time soruces, as well as make it easier to add future
> time sources. 

I would suggest taking it one small step farther and putting everything in 
their own subdirectory. Like arch/i386/kernel/timer/, at least for now. IF 
we ever get an arch/i386/driver/ subdir, it's simple enough to move the 
dir. One way or another, it unclutters the directory while achieving the 
same cleanup.


	-pat

