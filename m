Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbREUPtM>; Mon, 21 May 2001 11:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbREUPtC>; Mon, 21 May 2001 11:49:02 -0400
Received: from geos.coastside.net ([207.213.212.4]:12027 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261454AbREUPsp>; Mon, 21 May 2001 11:48:45 -0400
Mime-Version: 1.0
Message-Id: <p05100314b72ee5e52330@[207.213.214.37]>
In-Reply-To: <20010521181709.A15029@jurassic.park.msu.ru>
In-Reply-To: <20010520163323.G18119@athlon.random>
 <15112.26868.5999.368209@pizda.ninka.net>
 <20010521034726.G30738@athlon.random>
 <15112.48708.639090.348990@pizda.ninka.net>
 <20010521105944.H30738@athlon.random>
 <15112.55709.565823.676709@pizda.ninka.net>
 <20010521115631.I30738@athlon.random>
 <15112.59880.127047.315855@pizda.ninka.net>
 <15112.60362.447922.780857@pizda.ninka.net>
 <p05100311b72ecde57fcd@[207.213.214.37]>
 <20010521181709.A15029@jurassic.park.msu.ru>
Date: Mon, 21 May 2001 08:47:38 -0700
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: alpha iommu fixes
Cc: "David S. Miller" <davem@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <andrewm@uow.edu.au>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 6:17 PM +0400 2001-05-21, Ivan Kokshaysky wrote:
>On Mon, May 21, 2001 at 06:55:29AM -0700, Jonathan Lundell wrote:
>>  8 slots (and  you're right, 6 is a practical upper limit, fewer for
>>  66 MHz) *per bus*. Buses can proliferate like crazy, so the slot
>>  limit becomes largely irrelevant.
>
>True, but the bandwidth limit is highly relevant. That's why modern
>systems have multiple root buses, not a bridged ones.

Sure, there are systems with multiple root buses (I'm a bit fuzzy on 
how well Linux handles that), and bandwidth is important, but it's 
simply wrong to assume that a particular root bus will never have 
more than 6 or 8 devices. There are legitimate cases (firewalls 
spring to mind) where port count is driven by other considerations 
than aggregate bandwidth.
-- 
/Jonathan Lundell.
