Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUKWP5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUKWP5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 10:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbUKWPz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 10:55:56 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:55273 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261321AbUKWPsB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 10:48:01 -0500
Date: Tue, 23 Nov 2004 16:47:58 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <20041123133456.GA10453@elte.hu>
Message-Id: <Pine.OSF.4.05.10411231628300.23417-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'll try to grab -30-7 and work on from there. I am working on
variable dependency chains (locking tree depth). I'll try to send it as a
patch to -30-7. But I must admit it is very hard for me to follow
all your patches, getting them down, compiling etc: Once I am up
running on the newest version you have already sent out the next! :-)

Esben


On Tue, 23 Nov 2004, Ingo Molnar wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > >  From realfeel I wrote a small, simple test to test how well priority
> > > inheritance mechanism works. 
> > 
> > cool - this is a really useful testsuite.
> 
> FYI, i've put the 'blocker device' kernel code into the current -RT
> patch (-30-7). This makes it possible to build it on SMP (which didnt
> work when it was a module), and generally makes it easier to do testing
> via pi_test.
> 
> The only change needed on the userspace pi_test side was to add -O2 to
> the CFLAGS in the Makefile to make the loop() timings equivalent, and to
> remove the module compilations. I've added a .config option for it too
> and cleaned up the code.
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

