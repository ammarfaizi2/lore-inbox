Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129841AbQKFHet>; Mon, 6 Nov 2000 02:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130089AbQKFHe3>; Mon, 6 Nov 2000 02:34:29 -0500
Received: from waste.org ([209.173.204.2]:15138 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129841AbQKFHeT>;
	Mon, 6 Nov 2000 02:34:19 -0500
Date: Mon, 6 Nov 2000 01:34:14 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: barryn@pobox.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] document ECN in 2.4 Configure.help
In-Reply-To: <200011060615.WAA05490@cx518206-b.irvn1.occa.home.com>
Message-ID: <Pine.LNX.4.10.10011060113240.8248-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2000, Barry K. Nathan wrote:

> +CONFIG_INET_ECN
> +  Explicit Congestion Notification (ECN) allows routers to notify
> +  clients about network congestion, resulting in fewer dropped packets
> +  and increased network performance. This option adds ECN support to the
> +  Linux kernel, as well as a sysctl (/proc/sys/net/ipv4/tcp_ecn) which
> +  allows ECN support to be disabled at runtime.

You might mention the RFC here, 2481 IIRC.

> +  Note that, on the Internet, there are many broken firewalls which
> +  refuse connections from ECN-enabled machines, and it may be a while
> +  before these firewalls are fixed. Until then, to access a site behind
> +  such a firewall (some of which are major sites, at the time of this
> +  writing) you will have to disable this option, either by saying N now
> +  or by using the sysctl.

I'm still not sure why it's been decided not to do fallback or how this
whole situation is any different from path MTU discovery.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
