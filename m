Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132360AbRAJIuR>; Wed, 10 Jan 2001 03:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132365AbRAJIt6>; Wed, 10 Jan 2001 03:49:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44429 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132360AbRAJItw>;
	Wed, 10 Jan 2001 03:49:52 -0500
Date: Wed, 10 Jan 2001 00:31:09 -0800
Message-Id: <200101100831.AAA18269@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: manfred@colorfullife.com
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <3A5C2034.537B4C58@colorfullife.com> (message from Manfred Spraul
	on Wed, 10 Jan 2001 09:41:24 +0100)
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <3A5C2034.537B4C58@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 10 Jan 2001 09:41:24 +0100
   From: Manfred Spraul <manfred@colorfullife.com>

   That means sendmsg() changes the page tables?

Not in the zerocopy patch I am proposing and asking people to test.  I
stated in another email that MSG_NOCOPY was considered experimental
and thus left out of my patches.

   I measures smp_call_function on my Dual Pentium 350, and it took
   around 1950 cpu ticks.

And this is one of several reasons why the MSG_NOCOPY facility is
considered experimental.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
