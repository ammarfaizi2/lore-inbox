Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284937AbRLUQxu>; Fri, 21 Dec 2001 11:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284934AbRLUQwv>; Fri, 21 Dec 2001 11:52:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1034 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284778AbRLUQvp>;
	Fri, 21 Dec 2001 11:51:45 -0500
Date: Fri, 21 Dec 2001 17:50:45 +0100
From: Jens Axboe <axboe@kernel.org>
To: Dave Jones <davej@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>,
        William Lee Irwin III <wli@holomorphy.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Poor performance during disk writes
Message-ID: <20011221175045.B2929@suse.de>
In-Reply-To: <3C222BB5.B2CCC11B@zip.com.au> <Pine.LNX.4.33.0112201927440.2519-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112201927440.2519-100000@Appserv.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20 2001, Dave Jones wrote:
> On Thu, 20 Dec 2001, Andrew Morton wrote:
> 
> > You need to run
> > 	elvtune -b N /dev/hdXX
> > where N=0 is "disable", N=1 is minimum read latency, N=6 is
> > a reasonable setting.
> 
> I'm curious, why was max_bomb_segments dropped the last time
> it was in the tree ? I recall it happening, but the reason
> escapes me.

Fooled me too the first time, read Andrew's patch though. It isn't
related at all.

-- 
Jens Axboe

