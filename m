Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136379AbRAHHSS>; Mon, 8 Jan 2001 02:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136990AbRAHHSJ>; Mon, 8 Jan 2001 02:18:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6530 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136379AbRAHHRw>;
	Mon, 8 Jan 2001 02:17:52 -0500
Date: Sun, 7 Jan 2001 23:00:45 -0800
Message-Id: <200101080700.XAA10037@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: greearb@candelatech.com
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <3A597665.4B68C39@candelatech.com> (message from Ben Greear on
	Mon, 08 Jan 2001 01:12:21 -0700)
Subject: Re: [PATCH] hashed device lookup (New Benchmarks)
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com> <20010107042959.A14330@gruyere.muc.suse.de> <3A580B31.7998C783@candelatech.com> <20010107062744.A15198@gruyere.muc.suse.de> <3A58249F.86DD52BC@candelatech.com> <3A597665.4B68C39@candelatech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Mon, 08 Jan 2001 01:12:21 -0700
   From: Ben Greear <greearb@candelatech.com>

   http://grok.yi.org/~greear/hashed_dev.png
   (If you can't get to it, let me know and I'll email it to you...some
    cable modem networks have I firewalled.)

It just seems that this shows that the implementation of ifconfig can
be improved, since "ip" can do the same thing several orders of
magnitude better (ie. non-quadratic system time complexity).

This is the argument I started with when this thread began, so my
position hasn't changed, it has in fact been well supported by your
tests :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
