Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288113AbSBDU3W>; Mon, 4 Feb 2002 15:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288174AbSBDU3C>; Mon, 4 Feb 2002 15:29:02 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11524 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S288113AbSBDU26>; Mon, 4 Feb 2002 15:28:58 -0500
Date: Mon, 4 Feb 2002 15:28:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Athlon Optimization Problem
In-Reply-To: <Pine.LNX.4.33.0201301838520.23104-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.3.96.1020204152614.30424G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Mark Hahn wrote:

> > > Really?  VIA's own stuff doesn't touch 0x95?  Hmm.  Well is there ever a
> > > case where touching 0x95 solved ANYTHING?
> > > 
> > > What do you think?  Should I change the patch to not touch 0x95?
> > 
> > If this is the code I recall, we beat this to death ages ago. Some people
> > can't run without the fix, period, because user code will crash the
> > system. I have two like that, and while I could run the kernel as an i686
> > kernel, I can't protect the user code that way.
> 
> you have two kt266 boxes that crash without the fix to 0x95,
> or are you talking about kt133/kx/etc and their 0x55 fix?

You are so correct, I remembered the byte incorrectly, 0x55 is the one
needed. It was NOT the code I (almost) recall. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

