Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWCUVTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWCUVTY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWCUVTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:19:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2713 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751156AbWCUVTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:19:22 -0500
Date: Tue, 21 Mar 2006 13:19:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Sander <sander@humilis.net>, Mark Lord <liml@rtr.ca>,
       Mark Lord <lkml@rtr.ca>, Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
In-Reply-To: <44206B81.1030309@garzik.org>
Message-ID: <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org>
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca>
 <20060321121354.GB24977@favonius> <442004E4.7010002@rtr.ca>
 <20060321153708.GA11703@favonius> <Pine.LNX.4.64.0603211028380.3622@g5.osdl.org>
 <20060321191547.GC20426@favonius> <Pine.LNX.4.64.0603211132340.3622@g5.osdl.org>
 <20060321204435.GE25066@favonius> <Pine.LNX.4.64.0603211249270.3622@g5.osdl.org>
 <44206B81.1030309@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2006, Jeff Garzik wrote:
> 
> There were a bunch of sata_mv fixes in git-libata-all, all of which are
> actually now in your linux-2.6.git tree.

Ok. I wasn't sure that the latest libata merge had merged everything that 
was in -mm1, but if you think the relevant parts are there, then..

> In any case, one could be lazy, and simply bisect the main tree (and/or simply
> verify that the problem is gone in 2.6.16-git<today>).

Yes, just testing the current git tree (and if you're not a git user, just 
waiting for the next nightly snapshot) sounds like the appropriate thing 
to do.

Maybe back-porting any critical sata_mv fixes to 2.6.16.x is appropriate, 
considering that I don't think RH or SuSE will necessarily want to pull 
the whole thing.

		Linus
