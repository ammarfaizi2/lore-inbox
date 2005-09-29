Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVI2TTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVI2TTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVI2TTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:19:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:18317 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932225AbVI2TTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:19:03 -0400
X-Authenticated: #20450766
Date: Thu, 29 Sep 2005 21:18:23 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Peter Osterlund <petero2@telia.com>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
In-Reply-To: <m3hdc4ucrt.fsf@telia.com>
Message-ID: <Pine.LNX.4.60.0509292116260.11615@poirot.grange>
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange> <m3slvtzf72.fsf@telia.com>
 <Pine.LNX.4.60.0509252026290.3089@poirot.grange> <m34q873ccc.fsf@telia.com>
 <Pine.LNX.4.60.0509262122450.4031@poirot.grange> <m3slvr1ugx.fsf@telia.com>
 <Pine.LNX.4.60.0509262358020.6722@poirot.grange> <m3hdc4ucrt.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Peter Osterlund wrote:

> That patch changes the logic that decides when the driver should
> change between reading and writing. However, the read/write/sync
> sequence that makes your drive fail in 2.6.13 could theoretically
> happen in 2.6.12 as well if you are unlucky.

Well, I didn't test it extensively - it was the first time I tried it 
under 2.6.13.

> I think some trial and error will be required to figure out what
> causes your drive to fail. If you apply this patch to 2.6.12, does it
> still work?

Yes, it does...

Thanks
Guennadi
---
Guennadi Liakhovetski
