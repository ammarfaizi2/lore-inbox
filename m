Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbVJaGIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVJaGIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 01:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932823AbVJaGIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 01:08:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15801 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932541AbVJaGIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 01:08:47 -0500
Date: Sun, 30 Oct 2005 23:07:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: rmk+lkml@arm.linux.org.uk, torvalds@osdl.org, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-Id: <20051030230759.7ada7884.akpm@osdl.org>
In-Reply-To: <200510310341.02897.ak@suse.de>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<20051031001647.GK2846@flint.arm.linux.org.uk>
	<20051030172247.743d77fa.akpm@osdl.org>
	<200510310341.02897.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Monday 31 October 2005 02:22, Andrew Morton wrote:
> 
> > There is nothing stopping anyone from working with the originators to get
> > these things fixed up at any time.
> >
> > Why is it necessary for me to chase maintainers to get their bugs fixed?
> >
> > Why are maintainers working on new features when they have unresolved bugs?
> 
> Because zero bugs is just unrealistic and they would never get anything done
> if that was the requirement? 
> 
> (especially considering that a lot of the bugs at least on x86-64 are 
> hardware/firmware bugs of some sort, so often it is not really a linux
> bug but just a missing ha^w^wwork^w^w^w^wfix for something else) 
> 
> I agree regressions are a problem and need to be addressed, but handling all 
> non regressions on a non trivial platforms is just impossible IMHO...
> 
> Perhaps it would be nice to have better bug classification: e.g.
> regression/new hardware/reported by more than one person etc.  I think
> with some prioritization like that it would be much easier to keep the bugs
> under control. 

Well sure.  But who does that?  It should be the relevant maintainer, IMO. 
If that's the way in which he chooses to work.  Expecting some third party
to do this on a kenrel-wide basis won't fly.

> ...
> Sometimes bugs are less important than others.

I don't believe that what we're seeing is some prioritisation process.  The
problem is that some bugs are *harder* than others, and people are just
ducking things which cannot be locally reproduced.

