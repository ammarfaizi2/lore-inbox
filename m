Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261812AbREVOon>; Tue, 22 May 2001 10:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbREVOod>; Tue, 22 May 2001 10:44:33 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:2308 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261802AbREVOo1>; Tue, 22 May 2001 10:44:27 -0400
Date: Tue, 22 May 2001 18:44:09 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net,
        "David S. Miller" <davem@redhat.com>
Subject: Re: alpha iommu fixes
Message-ID: <20010522184409.A791@jurassic.park.msu.ru>
In-Reply-To: <15112.55709.565823.676709@pizda.ninka.net> <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net> <20010521125032.K30738@athlon.random> <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru> <20010521105339.A1907@twiddle.net> <20010522025658.A1116@athlon.random> <20010522162916.B15155@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010522162916.B15155@athlon.random>; from andrea@suse.de on Tue, May 22, 2001 at 04:29:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 04:29:16PM +0200, Andrea Arcangeli wrote:
> Ivan could you test the above fix on the platforms that needs the
> align_entry hack?

That was one of the first things I noticed, and I've tried exactly
that (2 instead of ~1UL).
No, it wasn't the cause of the crashes on pyxis, so I left it as is.
But probably it worth to be changed, at least for correctness.

Ivan.
