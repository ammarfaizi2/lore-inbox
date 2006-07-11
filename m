Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWGKQCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWGKQCj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWGKQCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:02:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17156 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751108AbWGKQCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:02:38 -0400
Date: Tue, 11 Jul 2006 18:02:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: andrea@cpushare.com
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060711160236.GX13938@stusta.de>
References: <1151628246.22380.58.camel@mindpipe> <20060629180706.64a58f95.akpm@osdl.org> <20060630014050.GI19712@stusta.de> <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu> <20060630145825.GA10667@opteron.random> <20060711073625.GA4722@elte.hu> <20060711141709.GE7192@opteron.random> <1152628374.3128.66.camel@laptopd505.fenrus.org> <20060711153117.GJ7192@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711153117.GJ7192@opteron.random>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 05:31:17PM +0200, andrea@cpushare.com wrote:
> On Tue, Jul 11, 2006 at 04:32:53PM +0200, Arjan van de Ven wrote:
>...
> > if there is overhead, and there is no general use for it (which there
> > isn't really) then it should be off imo.
> 
> I hope the reason was the lack of my last patch. But even in such case
> RH could have turned off the tsc thing immediately themself (they know
> how to patch the kernel no?) or they could have asked me a single
> question about it before turning it off, no?
> 
> I hope RH will reconsider with my last patch applied and at the light of
> this email as well:
> 
> 	http://www.cpushare.com/hypermail/cpushare-discuss/06/01/0080.html
> 
> If they don't reconsider I'll be forced to recommend the Fedora CPUShare
> users to switch distro if they don't want having to recompile the kernel
> by themself.
> 
> I guess now I understand why this new change of mind of Ingo: if he
> would succeed to push the N in the main kernel, then nobody could
> complain to fedora for setting it to N, while they're in a less obvious
> position at the moment where the kernel says "default to y" and they set
> it to N to be happy.
>...

WTF are you smoking?

You said yourself that your feature has currently exactly 121 users.

And why should anyone have to contact you before disabling your feature?
Everyone enables the subset of features he considers useful, and there's
no reason to contact anyone when disabling a feature in the kernel
(or would you consider it a morally bad thing that I disabled kernel 
preemption in my kernel without asking anyone for permission?).

And it was you who said just a few days ago [1]:

<--  snip  -->

...
If I've to keep reading these threads about CONFIG_SECCOMP every few
months then set it to N (even if I disagree with that setting). Like
Alan said, what really matters is what distro will choose in their
config, not the default (and I doubt fedora ships with cifs=Y like the
default where only the required stuff is set to Y, please focus on the
big stuff first ;).

<--  snip  -->

cu
Adrian

[1] http://lkml.org/lkml/2006/6/30/132

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

