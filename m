Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751922AbWIRVI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbWIRVI4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 17:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbWIRVIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 17:08:55 -0400
Received: from tentacle.snto-msu.net ([194.88.210.4]:27117 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S1751183AbWIRVIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 17:08:54 -0400
Date: Tue, 19 Sep 2006 01:08:49 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Andi Kleen <ak@suse.de>
Cc: Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-ID: <20060918210849.GA31746@tentacle.sectorb.msk.ru>
References: <4492D5D3.4000303@atmos.washington.edu> <44948EF6.1060201@atmos.washington.edu> <Pine.LNX.4.61.0606191638550.23553@ask.diku.dk> <200606191724.31305.ak@suse.de> <20060916120845.GA18912@tentacle.sectorb.msk.ru> <p73k6414lnp.fsf@verdi.suse.de> <20060918090330.GA9850@tentacle.sectorb.msk.ru> <p73eju94htu.fsf@verdi.suse.de> <20060918102918.GA23261@tentacle.sectorb.msk.ru> <p73ac4x4doi.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <p73ac4x4doi.fsf@verdi.suse.de>
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.17-rc6-64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 01:27:57PM +0200, Andi Kleen wrote:
> The codebase for timing (and lots of other things) is quite different
> between 32bit and 64bit. You're really surprised it doesn't work if you do such things?
> 
It works, and after your remark above, I'm surprised.
Dunno about slow TSC drift though, there was not enough time passed to
detect it, and I hope we will have this problem soved in a better way
before the drift becomes visible :)

> > But the question is, why stock 2.6.18-rc7 could not use TSC on its own?
> 
> x86-64 doesn't use the TSC when it deems it to not be reliable, which
> is the case on your system.
>  
Could it at least print something so that I know that using TSC  was
considered, but rejected?

> > What hardware exactly. Doesn't it affect only CPU? And they are not
> > know to fail before any other components.
> 
> All hardware. It's basic physics.

Hm, what other hardware is affected by idle=poll? Does this option ear
out HDDs?
~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

