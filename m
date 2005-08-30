Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVH3BpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVH3BpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 21:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVH3BpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 21:45:25 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:42715 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750811AbVH3BpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 21:45:25 -0400
Subject: Re: 2.6.13-rc7-rt4, fails to build
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1125364522.7630.108.camel@cmn37.stanford.edu>
References: <1125277360.2678.159.camel@cmn37.stanford.edu>
	 <20050829083541.GA21756@elte.hu>
	 <1125364522.7630.108.camel@cmn37.stanford.edu>
Content-Type: text/plain
Date: Mon, 29 Aug 2005 21:45:22 -0400
Message-Id: <1125366322.4598.101.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 18:15 -0700, Fernando Lopez-Lezcano wrote:
> On Mon, 2005-08-29 at 01:35, Ingo Molnar wrote: 
> > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > 
> > > I'm getting a build error for 2.6.13-rc7-rt4 with PREEMPT_DESKTOP for 
> > > i386:
> > 
> > hm, cannot reproduce this build problem on my current tree - could you 
> > try 2.6.13-rt1? (and please send the 2.6.13-rt1 .config if it still 
> > occurs)
> 
> I still get the error, it is happening in the _smp_ build, I don't know
> what's wrong...
> 
> arch/i386/mach-generic/built-in.o(.text+0x1183): In function
> `es7000_rename_gsi':

Well you could certainly work around it by using CONFIG_X86_PC rather
than CONFIG_X86_GENERICARCH unless you really needs to support the IBM
x440, Unisys ES7000, or something with more than 8 CPUs...

Lee

