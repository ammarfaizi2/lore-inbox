Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbTGOJEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 05:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266924AbTGOJEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 05:04:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31189 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265911AbTGOJDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 05:03:54 -0400
Date: Tue, 15 Jul 2003 11:18:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715091838.GJ833@suse.de>
References: <1058229360.13317.364.camel@tiny.suse.com> <20030714175238.3eaddd9a.akpm@osdl.org> <20030715020706.GC16313@dualathlon.random> <20030715054551.GD833@suse.de> <20030715060101.GB30537@dualathlon.random> <20030715060857.GG833@suse.de> <20030715070314.GD30537@dualathlon.random> <20030715082850.GH833@suse.de> <1058260347.4012.11.camel@tiny.suse.com> <20030715091730.GI833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715091730.GI833@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15 2003, Jens Axboe wrote:
> > BTW, the contest run times vary pretty wildy.  My 3 compiles with
> > io_load running on 2.4.21 were 603s, 443s and 515s.  This doesn't make
> > the average of the 3 numbers invalid, but we need a more stable metric.
> 
> Mine are pretty consistent [1], I'd suspect that it isn't contest but your
> drive tcq skewing things. But it would be nice to test with other things
> as well, I just used contest because it was at hand.

Oh and in the same spirit, I'll do the complete runs on an IDE drive as
well. Sometimes IDE vs SCSI shows the funniest things.

-- 
Jens Axboe

