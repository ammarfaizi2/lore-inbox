Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVIRAal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVIRAal (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 20:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVIRAak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 20:30:40 -0400
Received: from ozlabs.org ([203.10.76.45]:50072 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751250AbVIRAak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 20:30:40 -0400
Date: Sun, 18 Sep 2005 10:25:50 +1000
From: Anton Blanchard <anton@samba.org>
To: Soeren Sandmann <sandmann@daimi.au.dk>
Cc: John Levon <levon@movementarian.org>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: Announce:  Sysprof 1.0 -- a sampling, systemwide Linux profiler
Message-ID: <20050918002550.GB17639@krispykreme>
References: <ye8br2r9zi7.fsf@horse06.daimi.au.dk> <20050917211656.GA27448@outpost.ds9a.nl> <ye8slw38i5g.fsf@horse06.daimi.au.dk> <20050917222015.GA32019@trollied.org> <ye88xxvi9g3.fsf@zebra02.daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ye88xxvi9g3.fsf@zebra02.daimi.au.dk>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> My motive is not to duplicate oprofile - I basically don't care about
> the kernel level mechanism as long as it can produce stack traces that
> the GUI can interprete and analyse. In fact, one of the first times I
> wrote about sysprof publicly [1], I said:
> 
>       It seems to me that since oprofile probably reports more and
>       better data than my kernel module, we should try and get the
>       graphical presentation from sysprof to present oprofile data.
> 
> and I still think so, but it's a fairly substantial amount of work to
> get rid of 296 lines of code. 

Looking at your kernel module it should be pretty easy to plug on top of
oprofile callgraph data. All the hard work of programming hardware
performance counters will then come for free. Cross platform support
will also come for free.

Anton
