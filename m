Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTE3JT5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 05:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTE3JT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 05:19:57 -0400
Received: from [212.6.122.211] ([212.6.122.211]:26505 "EHLO mail3.ewetel.de")
	by vger.kernel.org with ESMTP id S263487AbTE3JT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 05:19:56 -0400
Date: Fri, 30 May 2003 11:33:07 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: David Wilson <david@uow.edu.au>
cc: linux-kernel@vger.kernel.org, <axboe@suse.de>
Subject: Re: capability flag for ATAPI MO (from kernel mailing list)
In-Reply-To: <20030530015334.GD1120@uow.edu.au>
Message-ID: <Pine.LNX.4.44.0305301130070.1076-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003, David Wilson wrote:

> Is optical (or CDC_OPTICAL) a good name for this capability?
> After all, CD CD-R CD-RW DVD DVD+/-R(W) are all optical.

Well, I simply used something similar to ide_optical from IDE code, but
I agree that it's not optimal.

> That said, a better name does not immediately spring to mind
> (unless MOPTICAL works for you - magneto-optical seems too long).

I'll see what Jens has to say about the name. CDC_MOPTICAL looks ugly
to me, and CDC_MO too short. Maybe CDC_MO_DRIVE would work if
CDC_OPTICAL is not acceptable.

-- 
Ciao,
Pascal

