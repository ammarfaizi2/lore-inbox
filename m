Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261767AbSJCRr5>; Thu, 3 Oct 2002 13:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261770AbSJCRr5>; Thu, 3 Oct 2002 13:47:57 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:61665 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261767AbSJCRr4>; Thu, 3 Oct 2002 13:47:56 -0400
Subject: Re: [PATCH] linux-2.5.40_timer-changes_A3 (1/3 - infrastructure)
From: john stultz <johnstul@us.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       george anzinger <george@mvista.com>
In-Reply-To: <Pine.LNX.4.44.0210030922210.27710-100000@cherise.pdx.osdl.net>
References: <Pine.LNX.4.44.0210030922210.27710-100000@cherise.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Oct 2002 10:48:22 -0700
Message-Id: <1033667302.28783.152.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 09:28, Patrick Mochel wrote:
> 
> > 	Inspired by suggestions from Alan, this collection of patches tries to
> > clean up time.c by breaking out the PIT and TSC specific parts into
> > their own files. Additionally the patch creates an abstract interface to
> > use these existing time soruces, as well as make it easier to add future
> > time sources. 
> 
> I would suggest taking it one small step farther and putting everything in 
> their own subdirectory. Like arch/i386/kernel/timer/, at least for now. IF 
> we ever get an arch/i386/driver/ subdir, it's simple enough to move the 
> dir. One way or another, it unclutters the directory while achieving the 
> same cleanup.

That sounds good. I'll do so before I resubmit. 

Thanks for the feedback!
-john

