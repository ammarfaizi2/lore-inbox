Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUJITbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUJITbG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 15:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUJITbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 15:31:06 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:49041 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267306AbUJITbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 15:31:03 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: stefan.eletzhofer@eletztrick.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041009212614.GA25441@tier.local>
References: <41677E4D.1030403@mvista.com> <416822B7.5050206@opersys.com>
	 <1097346628.1428.11.camel@krustophenia.net>
	 <20041009212614.GA25441@tier.local>
Content-Type: text/plain
Message-Id: <1097350227.1428.41.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 15:30:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 17:26, stefan.eletzhofer@eletztrick.de wrote:
> On Sat, Oct 09, 2004 at 02:30:28PM -0400, Lee Revell wrote:
> > On Sat, 2004-10-09 at 13:41, Karim Yaghmour wrote:
> > > Sven-Thorsten Dietrich wrote:
> > > >     - Voluntary Preemption by Ingo Molnar
> > > >     - IRQ thread patches by Scott Wood and Ingo Molnar
> > > >     - BKL mutex patch by Ingo Molnar (with MV extensions)
> > > >     - PMutex from Germany's Universitaet der Bundeswehr, Munich
> > > >     - MontaVista mutex abstraction layer replacing spinlocks with mutexes
> > > 
> > > To the best of my understanding, this still doesn't provide deterministic
> > > hard-real-time performance in Linux.
> > 
> > Using only the VP+IRQ thread patch, I ran my RT app for 11 million
> > cycles yesterday, with a maximum delay of 190 usecs.  How would this not
> > satisfy a 200 usec hard RT constraint?
> 
> I think the keyword here is "deterministic", isn't it?

Well, depends what you mean by deterministic.  Some RT apps only require
an upper bound on response time.  This is a form of determinism.

Lee 

