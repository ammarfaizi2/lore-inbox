Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264901AbSKJOv4>; Sun, 10 Nov 2002 09:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264902AbSKJOvz>; Sun, 10 Nov 2002 09:51:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52185 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264901AbSKJOvz>;
	Sun, 10 Nov 2002 09:51:55 -0500
Date: Sun, 10 Nov 2002 15:57:57 +0100
From: Jens Axboe <axboe@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.46-mm2
Message-ID: <20021110145757.GK31134@suse.de>
References: <3DCDD9AC.C3FB30D9@digeo.com> <20021110143208.GJ31134@suse.de> <20021110145203.GH23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021110145203.GH23425@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10 2002, William Lee Irwin III wrote:
> On Sat, Nov 09 2002, Andrew Morton wrote:
> >> And Jens's rbtree-based insertion code for the request queue.  Which
> >> means that the queues can be grown a *lot* if people want to play with
> >> that.  The VM should be able to cope with it fine.
> 
> On Sun, Nov 10, 2002 at 03:32:08PM +0100, Jens Axboe wrote:
> > I've attached a small document describing the deadline io scheduler
> > tunables. stream_unit is not in Andrew's version, yet, it uses a hard
> > defined 128KiB. Also, Andrew didn't apply the rbtree patch only the
> > tunable patch. So it uses the same insertion algorithm as the default
> > kernel, two linked lists.
> 
> Okay, then I'll want the rbtree code for benchmarking.

Sure, I want to talk akpm into merging the rbtree code for real. Or I
can just drop you my current version, if you want.

-- 
Jens Axboe

