Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283218AbRK2NRV>; Thu, 29 Nov 2001 08:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283219AbRK2NRK>; Thu, 29 Nov 2001 08:17:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28562 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283218AbRK2NRB>;
	Thu, 29 Nov 2001 08:17:01 -0500
Date: Thu, 29 Nov 2001 08:16:59 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] /proc/interrupts fixes
In-Reply-To: <20011129154611.A13470@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.4.21.0111290813480.9516-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Nov 2001, Ivan Kokshaysky wrote:

> Is /proc/interrupts now allowed only on s390, x86 and mips? ;-)

/me wonders how the heck did that #if survive...

Oh, well.  Sorry about that - it certainly needs to be removed; all
architectures are converted, so the thing is unconditional.

