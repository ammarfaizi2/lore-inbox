Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267580AbUHJRWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267580AbUHJRWu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUHJRRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:17:36 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11146 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267527AbUHJRNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:13:16 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040810171235.GA12157@elte.hu>
References: <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de>
	 <1092103522.761.2.camel@mindpipe> <20040810085849.GC26081@elte.hu>
	 <1092157841.3290.3.camel@mindpipe>  <20040810171235.GA12157@elte.hu>
Content-Type: text/plain
Message-Id: <1092158015.3290.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 13:13:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 13:12, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > OK, with CONFIG_M586TSC, I am getting a lot of lockups.  A few
> > happened during normal desktop use, and it locks up hard when starting
> > jackd.  Could this have anything to do with the ALSA drivers (which I
> > am compiling seperately from ALSA cvs) detecting my build system as
> > i686?  I have read that the C3 is more like a 486 (with MMX & 3DNow)
> > than a 686.
> 
> well, could you try M486 then?
> 

Sure, I want to try recompiling alsa-lib as well, there was a version
mismatch that may be the problem.

Lee

