Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVADPJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVADPJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVADPJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:09:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9735 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261670AbVADPIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:08:12 -0500
Date: Tue, 4 Jan 2005 16:08:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       davidsen@tmr.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104150810.GD3097@stusta.de>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104125738.GC2708@holomorphy.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 04:57:38AM -0800, William Lee Irwin III wrote:
> On Mon, Jan 03, 2005 at 02:24:12PM +0100, Diego Calleja wrote:
> >> 2.6 will stop having small issues in each release until 2.7 is forked just
> >> like 2.4 broke things until 2.5 was forked. The difference IMO
> >> is that linux development now avoids things like the unstability which the
> >> 2.4.10 changes caused and things like the fs corruption bugs we saw in 2.4
> 
> On Mon, Jan 03, 2005 at 02:47:27PM +0100, Adrian Bunk wrote:
> > The 2.6.9 -> 2.6.10 patch is 28 MB, and while the changes that went into 
> > 2.4 were limited since the most invasive patches were postponed for 2.5, 
> > now _all_ patches go into 2.6 .
> > Yes, -mm gives a bit more testing coverage, but it doesn't seem to be 
> > enough for this vast amount of changes.
> 
> No amount of testing coverage will ever suffice. You're trying to
> empirically establish the nonexistence of something, which is only
> possible to repudiate, and never to verify.

I claim:
The less and the less invasive patches go into the kernel, the less 
likely are breakages.

"enough" shouldn't say "mathematically exactly proven that no 
regressions exist" but more something like the pretty small number of 
regressions in recent 2.4 kernels.

> -- wli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

