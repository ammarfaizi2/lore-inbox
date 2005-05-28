Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVE1U5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVE1U5U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 16:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVE1U5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 16:57:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:37010 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261151AbVE1U5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 16:57:15 -0400
Subject: Re: RT patch acceptance
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050528195546.GG86087@muc.de>
References: <m1br6zxm1b.fsf@muc.de>
	 <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu>
	 <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu>
	 <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu>
	 <20050527133122.GF86087@muc.de> <20050527135310.GC16158@elte.hu>
	 <20050528195546.GG86087@muc.de>
Content-Type: text/plain
Date: Sat, 28 May 2005 16:57:13 -0400
Message-Id: <1117313833.5423.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-28 at 21:55 +0200, Andi Kleen wrote:
> On Fri, May 27, 2005 at 03:53:10PM +0200, Ingo Molnar wrote:
> > 
> > * Andi Kleen <ak@muc.de> wrote:
> > 
> > > AFAIK the kernel has quite regressed recently, but that was not true 
> > > (for reasonable sound) at least for some earlier 2.6 kernels and some 
> > > of the low latency patchkit 2.4 kernels.
> > 
> > (putting my scheduler maintainer hat on) was this under a stock !PREEMPT 
> > kernel?  
> 
> Yes. I did not run the numbers personally, but I was told 2.6.11+
> was already considerable worse for latency tests with jack than 2.6.8+
> (this was with vendor kernels in SUSE releases); and apparently
> 2.6.8 was already worse than earlier 2.6.4/5 kernels or the later 
> and better 2.4s. CONFIG_PREEMPT in all cases did not change the
> picture much. Sorry for being light on details; as I did 
> not run the tests personally.

Um, that sounds 100% backwards.  Starting around 2.6.8 the latency (as
measured by the smallest usable jack buffer size) improved drastically
with each release.  Check the linux-audio-user or linux-audio-dev
archives, many JACK users report that 2.6.10 or 2.6.11 is the first
mainline kernel that gives acceptable performance at all.  In fact,
starting around 2.6.11 some pro audio users have been switching back
from PREEMPT_RT to mainline as a result.

Lee

