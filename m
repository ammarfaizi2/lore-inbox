Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283009AbRK1Dg7>; Tue, 27 Nov 2001 22:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283010AbRK1Dgt>; Tue, 27 Nov 2001 22:36:49 -0500
Received: from node10450.a2000.nl ([24.132.4.80]:5760 "EHLO awacs.dhs.org")
	by vger.kernel.org with ESMTP id <S281870AbRK1Dgl>;
	Tue, 27 Nov 2001 22:36:41 -0500
Date: Wed, 28 Nov 2001 04:36:36 +0100
From: Pascal Haakmat <a.haakmat@chello.nl>
To: linux-kernel@vger.kernel.org
Subject: [CRASH (kswapd)]: Unable to handle kernel NULL pointer dereference at virtual address 00000018
Message-ID: <20011128043636.A4128@awacs.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.14 with XFS 1.0.2 patch (but without kdb patch) crashed on me
today. The on screen crash dump said something about kswapd.

I managed to salvage the following information from the screen before the
screen went black (courtesy of the screen blanker?). I didn't find any way
to get the display back so the rest of the information was lost:

---
Unable to handle kernel NULL pointer dereference at virtual address 00000018
 printing eip:
c0137b20
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c0137b20>]
 
[lost, something about kswapd in all of this]
---

The machine is a dual 600MHz PIII with 512 MB RAM and 1 GB of swap. I had
been running 2.4.14 for almost exactly two days when it crashed. There was
no significant load on the system at the time of the crash. Before this I
had been running 2.4.5 with no such problems (but other problems, such as
mysterious hangs, possibly related to the non-free OSS sound drivers or gcc
or XFS in order of suspicion).

I suppose this is not much use but perhaps it can serve as a data point. I'd
happily provide more information but with most of the crash dump lost I'm
not sure how. Please Cc: through email if you think there is some other info
that I could provide. Thanks.

