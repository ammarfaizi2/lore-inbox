Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTE0TVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTE0TVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:21:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24195 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263761AbTE0TVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:21:49 -0400
Date: Tue, 27 May 2003 21:34:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH 2.4.21-rc4] Fix oom killer braindamage
Message-ID: <20030527193439.GU845@suse.de>
References: <200305272104.05802.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271611410.9487@freak.distro.conectiva> <200305272118.29554.m.c.p@wolk-project.de> <200305272130.43814.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305272130.43814.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27 2003, Marc-Christian Petersen wrote:
> On Tuesday 27 May 2003 21:18, Marc-Christian Petersen wrote:
> 
> Hi again ^3 ;)
> 
> > > Not suitable for -rc. Btw, -rc5 is already at bkbits.net.
> Please, if there is any chance we can fix the pause/stop bug, delay .21 final 
> for some hours or a day (or maybe two)
> 
> I've CC'ed akpm and Axboe. I think they are the only ones knowing enough about 
> the code to see an obvious error and even fixing the bug?!
> 
> Do you agree? Does anyone else agree? Or disagree?

I have to agree with Marcelo, nothing in ll_rw_blk is obvious enough to
just be changed at will in -rc5 time.

I need to catch up with this thread, hopefully we can get things fixed
around 2.4.22-early.

-- 
Jens Axboe

