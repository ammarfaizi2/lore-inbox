Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbREUBB6>; Sun, 20 May 2001 21:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbREUBBs>; Sun, 20 May 2001 21:01:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56477 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262291AbREUBBm>;
	Sun, 20 May 2001 21:01:42 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.26868.5999.368209@pizda.ninka.net>
Date: Sun, 20 May 2001 18:01:40 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010520163323.G18119@athlon.random>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru>
	<20010519155502.A16482@athlon.random>
	<20010519231131.A2840@jurassic.park.msu.ru>
	<20010520044013.A18119@athlon.random>
	<3B07AF49.5A85205F@uow.edu.au>
	<20010520154958.E18119@athlon.random>
	<3B07CF20.2ABB5468@uow.edu.au>
	<20010520163323.G18119@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > > Well this is news to me.  No drivers understand this.
 > 
 > Yes, almost all drivers are buggy.

No, the interface says that the DMA routines may not return failure.

If you want to change the DMA api to act some other way, then fine
please propose it, but do not act as if today they have to act this
way because that is simply not true.

Later,
David S. Miller
davem@redhat.com
