Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbSKKPli>; Mon, 11 Nov 2002 10:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbSKKPli>; Mon, 11 Nov 2002 10:41:38 -0500
Received: from [195.223.140.107] ([195.223.140.107]:42629 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265708AbSKKPli>;
	Mon, 11 Nov 2002 10:41:38 -0500
Date: Mon, 11 Nov 2002 16:48:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>,
       Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021111154802.GF30193@dualathlon.random>
References: <20021111015445.GB5343@x30.random> <Pine.LNX.4.44L.0211111139450.30221-100000@imladris.surriel.com> <20021111140920.GA838@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021111140920.GA838@suse.de>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 03:09:20PM +0100, Jens Axboe wrote:
> latency view point. This is also why the 2.5 deadline io scheduler is
> far superior in this area.

going in function of time is even better of course, but just assuming
bytes to be a linear function of time would be a good start, it depends
if you want to backport the deadline I/O scheduler to 2.4 or not. I
think going in terms of bytes would be simpler for 2.4. We're going to
use 2.4 for at least one more year in some production environment, so I
think it could make sense to address this, at least to be a function of
bytes if not of time.

Andrea
