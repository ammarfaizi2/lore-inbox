Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131129AbQLZBFf>; Mon, 25 Dec 2000 20:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbQLZBFZ>; Mon, 25 Dec 2000 20:05:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47120 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131129AbQLZBFH>; Mon, 25 Dec 2000 20:05:07 -0500
Date: Mon, 25 Dec 2000 16:34:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jasper Spaans <jasper@spaans.ds9a.nl>
cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: [bug] test13-pre4 nfs/ip_defrag crash (smp)
In-Reply-To: <20001225225925.A1276@spaans.ds9a.nl>
Message-ID: <Pine.LNX.4.10.10012251632310.6546-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Dec 2000, Jasper Spaans wrote:
> 
> I am having some reproducible crashes with 2.4.0-test13-pre4, whenever I
> do some 'heavy' nfs-ing.. decoded oops:

It looks like most of what you have is modules. Is netfilter enabled as a
module too? Can you reproduce it without modules, in case it's a
autounload race or similar?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
