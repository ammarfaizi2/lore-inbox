Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbTIHOVV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbTIHOVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:21:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42746 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262394AbTIHOVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:21:08 -0400
Date: Mon, 8 Sep 2003 16:20:46 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, peter_daum@t-online.de
Subject: Re: [2.4 patch] fix CONFIG_X86_L1_CACHE_SHIFT
Message-ID: <20030908142046.GA28062@fs.tum.de>
References: <3F5B96C3.1060706@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5B96C3.1060706@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 10:36:19PM +0200, Manfred Spraul wrote:
> Adrian wrote:
> 
> >With CONFIG_M686 CONFIG_X86_L1_CACHE_SHIFT was set to 5, but a Pentium 4 
> >requires 7.
> > 
> >
> Why requires? On x86, the cpu caches are fully coherent. A too small L1 
> cache shift results in false sharing on SMP, but it shouldn't cause the 
> described problems.
>...

Thanks for the correction, I falsely thought CONFIG_X86_L1_CACHE_SHIFT 
does something different than it does.

>    Manfred

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

