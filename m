Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129932AbQKFHqU>; Mon, 6 Nov 2000 02:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129374AbQKFHqK>; Mon, 6 Nov 2000 02:46:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16320 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129663AbQKFHp6>;
	Mon, 6 Nov 2000 02:45:58 -0500
Date: Sun, 5 Nov 2000 23:30:41 -0800
Message-Id: <200011060730.XAA31897@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: oxymoron@waste.org
CC: barryn@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011060113240.8248-100000@waste.org> (message
	from Oliver Xymoron on Mon, 6 Nov 2000 01:34:14 -0600 (CST))
Subject: Re: [PATCH] document ECN in 2.4 Configure.help
In-Reply-To: <Pine.LNX.4.10.10011060113240.8248-100000@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Mon, 6 Nov 2000 01:34:14 -0600 (CST)
   From: Oliver Xymoron <oxymoron@waste.org>

   I'm still not sure why it's been decided not to do fallback or how
   this whole situation is any different from path MTU discovery.

We don't use fallbacks for path MTU discovery (I assume you are
referring to black hole detection, we don't do it, never have never
will), you have to explicitly turn path-mtu discovery off.  It's been
on by default for 3 or 4 years now :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
