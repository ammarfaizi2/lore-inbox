Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWCRMzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWCRMzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 07:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWCRMzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 07:55:00 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14013 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751601AbWCRMzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 07:55:00 -0500
Date: Sat, 18 Mar 2006 05:54:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.16-rc6-rt7
Message-ID: <20060318125459.GB32662@smtp.west.cox.net>
References: <20060316095607.GA28571@elte.hu> <20060317233636.GB26253@smtp.west.cox.net> <20060318085725.GE23317@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318085725.GE23317@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 09:57:25AM +0100, Ingo Molnar wrote:
> 
> * Tom Rini <trini@kernel.crashing.org> wrote:
> 
> > On Thu, Mar 16, 2006 at 10:56:08AM +0100, Ingo Molnar wrote:
> > 
> > > i have released the 2.6.16-rc6-rt7 tree, which can be downloaded from 
> > > the usual place:
> > > 
> > >    http://redhat.com/~mingo/realtime-preempt/
> > 
> > I was wondering, is it normal for the nanosleep02 and alarm02 LTP 
> > tests to fail?  For sometime I've seen these tests fail from time to 
> > time with the -RT patch but not the regular kernel.
> 
> no, it's not normal. How repeatable is it?

With the feb. release of LTP I was 2/2 (./runltp -p -q -l /tmp/run.log
-o /tmp/run.out).  I've seen it in previous ones as well, and I think I
saw it in the one run I did of the March release as well.

-- 
Tom Rini
http://gate.crashing.org/~trini/
