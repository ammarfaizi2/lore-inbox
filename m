Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQJ3PMn>; Mon, 30 Oct 2000 10:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129043AbQJ3PMc>; Mon, 30 Oct 2000 10:12:32 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:50436 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129033AbQJ3PMU>; Mon, 30 Oct 2000 10:12:20 -0500
Date: Mon, 30 Oct 2000 15:11:46 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <andrewm@uow.edu.au>
cc: "Stephen E. Clark" <sclark46@gte.net>, lk <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: RTNL assert
In-Reply-To: <39FAAFF2.200E1860@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0010301505550.14004-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2000, Andrew Morton wrote:

> The rtnetlink lock needs to be taken around
> register_netdevice().  There should be a function
> which does these three common steps, but there isn't.

I thought the only difference between register_netdev() and
register_netdevice() was that one took the rtnl_lock and the other didn't?

But it's been a while since I played with networking code.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
