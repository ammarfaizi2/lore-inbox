Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVCCOwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVCCOwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 09:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVCCOwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 09:52:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15620 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261786AbVCCOvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 09:51:50 -0500
Date: Thu, 3 Mar 2005 15:51:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050303145147.GX4608@stusta.de>
References: <20050223014233.6710fd73.akpm@osdl.org> <20050224215136.GK8651@stusta.de> <20050224224134.GE20715@opteron.random> <20050225211453.GC3311@stusta.de> <20050226013137.GO20715@opteron.random> <20050301003247.GY4021@stusta.de> <20050301004449.GV8880@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301004449.GV8880@opteron.random>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 01:44:49AM +0100, Andrea Arcangeli wrote:
> On Tue, Mar 01, 2005 at 01:32:47AM +0100, Adrian Bunk wrote:
> > If you want to use Cpushare, you know that you have to enable seccomp.
> 
> Oh yeah, I know it, you know it, but not everyone will know it while
> configuring the kernel, infact I doubt they'll even know what Cpushare
> is about while they configure the kernel ;). And I doubt they should be
> required to know all those details in order to make that choice, and my
> point is that seccomp is low overhead enough that everyone can enable it
> if they're unsure, just in case. I'm just trying to explain why I
> recommend it to Y by default "if unsure".

My point is simply:

The help text for an option you need only under very specific 
circumstances shouldn't sound as if this option was nearly was 
mandatory.

For me, that's a question principle, not of risks of breakage or code 
size.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

