Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbREUOTv>; Mon, 21 May 2001 10:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261560AbREUOTl>; Mon, 21 May 2001 10:19:41 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:45575 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261550AbREUOT2>; Mon, 21 May 2001 10:19:28 -0400
Date: Mon, 21 May 2001 18:17:09 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: "David S. Miller" <davem@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <andrewm@uow.edu.au>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521181709.A15029@jurassic.park.msu.ru>
In-Reply-To: <20010520163323.G18119@athlon.random> <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net> <15112.60362.447922.780857@pizda.ninka.net> <p05100311b72ecde57fcd@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p05100311b72ecde57fcd@[207.213.214.37]>; from jlundell@pobox.com on Mon, May 21, 2001 at 06:55:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 06:55:29AM -0700, Jonathan Lundell wrote:
> 8 slots (and  you're right, 6 is a practical upper limit, fewer for 
> 66 MHz) *per bus*. Buses can proliferate like crazy, so the slot 
> limit becomes largely irrelevant.

True, but the bandwidth limit is highly relevant. That's why modern
systems have multiple root buses, not a bridged ones.

Ivan.
