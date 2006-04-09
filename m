Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWDISG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWDISG4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 14:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWDISG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 14:06:56 -0400
Received: from mail.gmx.de ([213.165.64.20]:45963 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750833AbWDISG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 14:06:56 -0400
X-Authenticated: #14349625
Subject: Re: [patch][rfc] quell interactive feeding frenzy
From: Mike Galbraith <efault@gmx.de>
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <20060409121436.GA28075@outpost.ds9a.nl>
References: <1144402690.7857.31.camel@homer>
	 <200604072256.27665.kernel@kolivas.org> <1144417064.8114.26.camel@homer>
	 <200604072356.03580.kernel@kolivas.org> <1144419294.14231.7.camel@homer>
	 <20060409111436.GA26533@outpost.ds9a.nl> <1144582778.13991.10.camel@homer>
	 <20060409121436.GA28075@outpost.ds9a.nl>
Content-Type: text/plain
Date: Sun, 09 Apr 2006 20:07:41 +0200
Message-Id: <1144606061.7408.14.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-09 at 14:14 +0200, bert hubert wrote:
> On Sun, Apr 09, 2006 at 01:39:38PM +0200, Mike Galbraith wrote:
> > Ok, unusable may be overstated.  Nonetheless, that bit of code causes
> > serious problems.  It makes my little PIII/500 test box trying to fill
> > one 100Mbit local network unusable.  That is not overstated.
> 
> If you try to make a PIII/500 fill 100mbit of TCP/IP using lots of different
> processes, that IS a corner load.
>  
> I'm sure you can fix this (rare) workload but are you very sure you are not
> killing off performance for other situations?

Rare?  What exactly is rare about a number of tasks serving data?  I
don't care if it's a P4 serving gigabit.  If you have to divide your
server into pieces (you do, and you know it) you're screwed. 

> I get flashbacks to the old days of the VM where we had lots patches around
> that would all solve (more or less) real problems, but never all at the same
> time..

I choose to take the high road here, and will not respond.

	-Mike

