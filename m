Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280056AbRLLN7Q>; Wed, 12 Dec 2001 08:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280059AbRLLN7G>; Wed, 12 Dec 2001 08:59:06 -0500
Received: from [213.196.40.44] ([213.196.40.44]:20689 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S280056AbRLLN64>;
	Wed, 12 Dec 2001 08:58:56 -0500
Date: Wed, 12 Dec 2001 12:49:56 +0100 (CET)
From: <bvermeul@devel.blackstar.nl>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-pre8 oopses on non existing acorn partition
In-Reply-To: <20011211114531.GP13498@suse.de>
Message-ID: <Pine.LNX.4.33.0112121249400.19609-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2001, Jens Axboe wrote:

> On Tue, Dec 11 2001, Jens Axboe wrote:
> > On Tue, Dec 11 2001, Bas Vermeulen wrote:
> > > 2.5.1-pre8 oopses in adfspart_check_ICS (probably the put_dev_sector,
> > > not entirely sure, since there doesn't seem to be anything wrong).
> > > I've enabled advanced partitions, and all the partition types.
> > > Disabling advanced partitions fixes it.
> >
> > Please try attached patch.
>
> Updated version, needs pagemap as well. Actually, it's the 2nd time this
> bit us in 2.5 now.

Works for me. Thanks!

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

