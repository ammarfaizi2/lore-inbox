Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136655AbRAJVjl>; Wed, 10 Jan 2001 16:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136673AbRAJVjd>; Wed, 10 Jan 2001 16:39:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62853 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136655AbRAJVjL>;
	Wed, 10 Jan 2001 16:39:11 -0500
Date: Wed, 10 Jan 2001 13:39:01 -0800
Message-Id: <200101102139.NAA07105@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: hacksaw@hacksaw.org
CC: kernel@ddx.a2000.nu, linux-kernel@vger.kernel.org
In-Reply-To: <200101102136.f0ALaEr01228@habitrail.home.fools-errant.com>
	(message from Hacksaw on Wed, 10 Jan 2001 16:36:14 -0500)
Subject: Re: unexplained high load
In-Reply-To: <200101102136.f0ALaEr01228@habitrail.home.fools-errant.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 10 Jan 2001 16:36:14 -0500
   From: Hacksaw <hacksaw@hacksaw.org>

   You'll have to reboot to clear it. I believe this is a kernel
   bug. Try going back to 2.2.14, or maybe up to 2.2.19pre2.

He needs to go up if anything.  His sparc64 OOPS had strings in the
kernel stack, which is indicative of a sparc64 specific bug I only
fixed very late in the 2.2.18 patches.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
