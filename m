Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317570AbSHHNU0>; Thu, 8 Aug 2002 09:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317571AbSHHNU0>; Thu, 8 Aug 2002 09:20:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22985 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317570AbSHHNUZ>;
	Thu, 8 Aug 2002 09:20:25 -0400
Date: Thu, 8 Aug 2002 15:23:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Oliver Xymoron <oxymoron@waste.org>, Jesse Barnes <jbarnes@sgi.com>,
       Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       phillips@arcor.de, rml@tech9.net
Subject: Re: [PATCH] lock assertion macros for 2.5.30
Message-ID: <20020808132344.GN2243@suse.de>
References: <20020807210855.GA27182@sgi.com> <Pine.LNX.4.44.0208071618290.16458-100000@waste.org> <20020808125505.GA8804@reload.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020808125505.GA8804@reload.namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08 2002, Joshua MacDonald wrote:
> In order to implement MOST_NOT_HOLD_LOCK the spinlock must contain
> some record of who holds the lock, and since the SCSI-layer apparently

Correct

> does not have such a mechanism, it appears that something is broken in
> there.

I'll restate, the SCSI layer does _not_ use ASSERT_LOCK in the kernel!
If just one of the people that keep raising this point would actually
see what it does rather than assume, we would not keep seeing this
mentioned in this discussion!

-- 
Jens Axboe

