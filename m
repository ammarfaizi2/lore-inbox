Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbSKKHhH>; Mon, 11 Nov 2002 02:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265646AbSKKHhH>; Mon, 11 Nov 2002 02:37:07 -0500
Received: from holomorphy.com ([66.224.33.161]:62388 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265643AbSKKHhH>;
	Mon, 11 Nov 2002 02:37:07 -0500
Date: Sun, 10 Nov 2002 23:41:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.46-mm2
Message-ID: <20021111074129.GK23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@digeo.com>,
	lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <3DCDD9AC.C3FB30D9@digeo.com> <20021110143208.GJ31134@suse.de> <20021110145203.GH23425@holomorphy.com> <20021110145757.GK31134@suse.de> <20021110150626.GI23425@holomorphy.com> <20021110155851.GL31134@suse.de> <3DCEB5E7.5147A449@digeo.com> <20021111070400.GP31134@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021111070400.GP31134@suse.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 08:04:00AM +0100, Jens Axboe wrote:
> I've already done exactly this (mempool per queue, global slab). I'll
> share it later today.
> But yes, lets see some numbers on huge queues first. Otherwise we can
> just fall back to using a decent 128/512 split for reads/writes, or
> whatever is a good split.

This just got real hard real fast and we'll be waiting at least a week
for "real" results from me.

Sorry, I can't fix vendor drivers on-demand. Recent SCSI changes broke
the out-of-tree crap and I don't have the driver and/or in-kernel SCSI/FC
expertise to deal with it.


Bill
