Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVJIVYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVJIVYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 17:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVJIVYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 17:24:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:12203 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932295AbVJIVYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 17:24:15 -0400
X-Authenticated: #20450766
Date: Sun, 9 Oct 2005 23:23:35 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Peter Osterlund <petero2@telia.com>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
In-Reply-To: <m3k6gw86f0.fsf@telia.com>
Message-ID: <Pine.LNX.4.60.0510092304550.14767@poirot.grange>
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange> <m3slvtzf72.fsf@telia.com>
 <Pine.LNX.4.60.0509252026290.3089@poirot.grange> <m34q873ccc.fsf@telia.com>
 <Pine.LNX.4.60.0509262122450.4031@poirot.grange> <m3slvr1ugx.fsf@telia.com>
 <Pine.LNX.4.60.0509262358020.6722@poirot.grange> <m3hdc4ucrt.fsf@telia.com>
 <Pine.LNX.4.60.0509292116260.11615@poirot.grange> <m3k6gw86f0.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2005, Peter Osterlund wrote:

> OK, in that case this patch for 2.6.12 should work as well, because
> all it does compared to the previous patch is to remove the now unused
> high_prio_read variables. Can you confirm that it works?

Yes, it does.

> With that patch for 2.6.12, the diff compared to 2.6.13 now looks like
> below. Can you confirm that reverse applying this patch for 2.6.13
> also works?

Well, I am testing always with 2.6.13 kernel, just replacing the pktcdvd 
driver sources. So, I just checked that 2.6.13 - your 2nd patch from the 
last email == 2.6.12 + 1st patch from the same email ( + trivial 
refrigerator() call compile-fix), so, we may save us this test.

Thanks
Guennadi
---
Guennadi Liakhovetski
