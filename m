Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266957AbTGOJRM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 05:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266985AbTGOJRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 05:17:12 -0400
Received: from 69-55-72-150.ppp.netsville.net ([69.55.72.150]:44755 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S266957AbTGOJRJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 05:17:09 -0400
Subject: Re: RFC on io-stalls patch
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, akpm@digeo.com
In-Reply-To: <20030715091838.GJ833@suse.de>
References: <1058229360.13317.364.camel@tiny.suse.com>
	 <20030714175238.3eaddd9a.akpm@osdl.org>
	 <20030715020706.GC16313@dualathlon.random> <20030715054551.GD833@suse.de>
	 <20030715060101.GB30537@dualathlon.random> <20030715060857.GG833@suse.de>
	 <20030715070314.GD30537@dualathlon.random> <20030715082850.GH833@suse.de>
	 <1058260347.4012.11.camel@tiny.suse.com> <20030715091730.GI833@suse.de>
	 <20030715091838.GJ833@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1058261439.4016.22.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 15 Jul 2003 05:30:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-15 at 05:18, Jens Axboe wrote:
> On Tue, Jul 15 2003, Jens Axboe wrote:
> > > BTW, the contest run times vary pretty wildy.  My 3 compiles with
> > > io_load running on 2.4.21 were 603s, 443s and 515s.  This doesn't make
> > > the average of the 3 numbers invalid, but we need a more stable metric.
> > 
> > Mine are pretty consistent [1], I'd suspect that it isn't contest but your
> > drive tcq skewing things. But it would be nice to test with other things
> > as well, I just used contest because it was at hand.
> 

tcq is at 32, the controller is aic7xxx, the drive is an older wdc.

> Oh and in the same spirit, I'll do the complete runs on an IDE drive as
> well. Sometimes IDE vs SCSI shows the funniest things.

Thanks.

