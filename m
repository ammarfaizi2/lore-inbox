Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261647AbTCGPjP>; Fri, 7 Mar 2003 10:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbTCGPjP>; Fri, 7 Mar 2003 10:39:15 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:13220
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261627AbTCGPjM>; Fri, 7 Mar 2003 10:39:12 -0500
Date: Fri, 7 Mar 2003 10:47:22 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: ChristopherHuhn <c.huhn@gsi.de>
cc: linux-smp <linux-smp@vger.kernel.org>, "" <linux-kernel@vger.kernel.org>,
       Walter Schoen <w.schoen@gsi.de>, "" <support-gsi@credativ.de>
Subject: Re: Kernel Bug at spinlock.h ?!
In-Reply-To: <3E674A13.5020203@GSI.de>
Message-ID: <Pine.LNX.4.50.0303071043580.18716-100000@montezuma.mastecende.com>
References: <Pine.LNX.3.95.1030303103332.22802A-100000@chaos> <3E637CDC.3030409@GSI.de>
 <Pine.LNX.4.50.0303031248220.29455-100000@montezuma.mastecende.com>
 <3E64B0EA.4080109@GSI.de> <Pine.LNX.4.50.0303042133170.5867-100000@montezuma.mastecende.com>
 <3E674A13.5020203@GSI.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, ChristopherHuhn wrote:

> Hi again,
> 
> >It looks like a possible race with rpc_execute and possibly the timer, 
> >although i can't be certain where the other cpus are. Do the other oopses 
> >look somewhat similar? Could you supply them?
> >  
> >
> below are some oopses I gathered yesterday and today, all on different 
> machines.
> I'd like to remark that we experience massive NFS problems at the moment 
> that seem to be caused by our mixed potato 2.2/ woody 2.4 environment, 
> i. e. linking apps on a woody system with the sources  mounted via nfs 
> from a potato box leads to obscure IO failures like "no space left on 
> device" (This never happens with woddy only). So this might be a clue 
> here as well.
> 
> The oopses are all written down from the screen, I hopefully made little 
> "transmission" errors.

Some of these are a bit worrying seeing as they are bit flips, also they 
all appear to come from a UP machine(?) this would change things with 
respect to my previous comment about races. Regarding weird io failures 
are you mounting with the 'soft' option?

	Zwane

