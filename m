Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWKKSxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWKKSxq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 13:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbWKKSxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 13:53:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52753 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751452AbWKKSxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 13:53:45 -0500
Date: Sat, 11 Nov 2006 19:53:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM in 2.6.19-rc*
Message-ID: <20061111185349.GD25057@stusta.de>
References: <Pine.LNX.4.64.0611111318230.1247@sheep.housecafe.de> <20061111181937.GC25057@stusta.de> <Pine.LNX.4.64.0611111832180.1247@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611111832180.1247@sheep.housecafe.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 06:38:05PM +0000, Christian Kujau wrote:
> On Sat, 11 Nov 2006, Adrian Bunk wrote:
> >Can you test whether an older kernel (preferably the one that worked
> >before) shows the same problem?
> 
> I could try 2.6.17...but currently I don't know how to reproduce the OOM 
> condition - so I'd have to wait 24h until *something* happens and the 
> OOM killer kicks in.

If you want to know what caused your provlem, this is the logical first 
step.

> >This way you might know whether it's a kernel problem or a distribution
> >problem.
> 
> I think I'm more interested as to why the OOM killer seems to kill 
> innocent apps at random. I can imagine that it's not easy for the kernel 
> to tell which userland-application is using up too much memory. Hm, 
> egrep -r "OOM|ut of memory" Documentation/    does not reveal much :(

mm/oom_kill.c is well documented.

> Thanks,
> Christian.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

