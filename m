Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbSJQMyN>; Thu, 17 Oct 2002 08:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSJQMyN>; Thu, 17 Oct 2002 08:54:13 -0400
Received: from ns.suse.de ([213.95.15.193]:61194 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261528AbSJQMyL>;
	Thu, 17 Oct 2002 08:54:11 -0400
Date: Thu, 17 Oct 2002 15:00:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre11aa1
Message-ID: <20021017150008.C8863@oldwotan.suse.de>
References: <20021016165155.GE30254@dualathlon.random> <200210172204.50297.harisri@bigpond.com> <20021017141005.A8863@oldwotan.suse.de> <200210172302.24409.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210172302.24409.harisri@bigpond.com>; from harisri@bigpond.com on Thu, Oct 17, 2002 at 11:02:24PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 11:02:24PM +1000, Srihari Vijayaraghavan wrote:
> Sorry if it was not clear. The -aa kernel crashes _only_ when I have agpgart 
> and radeon support (either as modules or as built-in the kernel). If there is 
> no agpgart and radeon support enabled, it does not crash.

ok. So the mystery is why it crashes only with my tree. there are no
changes to the graphics/gart drivers as far as I can tell. Now I even
wonder about a collision of dma with the sound driver or something weird
like that ;)

> > It doesn't make any sense that 2.4.20-pre11 works and my tree doesn't,
> > there are no changes to those sound and graphics driver. Can you make
> > sure that modversions is enabled, and please send me your .config.
> 
> Here is my current .config. While this one doesn't have modversions enabled I 
> have seen crashes even when it is enabled.

ok. but you can left modversions enabled, I do it myself too ;)

Andrea
