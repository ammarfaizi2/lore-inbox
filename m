Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261966AbREVP4Q>; Tue, 22 May 2001 11:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261969AbREVP4E>; Tue, 22 May 2001 11:56:04 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:1540 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261966AbREVPzx>; Tue, 22 May 2001 11:55:53 -0400
Date: Tue, 22 May 2001 19:55:18 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net,
        "David S. Miller" <davem@redhat.com>
Subject: Re: alpha iommu fixes
Message-ID: <20010522195518.A653@jurassic.park.msu.ru>
In-Reply-To: <15112.59880.127047.315855@pizda.ninka.net> <20010521125032.K30738@athlon.random> <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru> <20010521105339.A1907@twiddle.net> <20010522025658.A1116@athlon.random> <20010522162916.B15155@athlon.random> <20010522184409.A791@jurassic.park.msu.ru> <20010522171815.F15155@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010522171815.F15155@athlon.random>; from andrea@suse.de on Tue, May 22, 2001 at 05:18:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 05:18:15PM +0200, Andrea Arcangeli wrote:
> just in case (I guess it wouldn't matter much but), but are you sure you
> tried it with also the locking fixes applied too?

Yes. Though those races more likely would cause silent data
corruption, but not immediate crash.

Ivan.
