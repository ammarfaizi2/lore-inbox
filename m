Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRAYOxT>; Thu, 25 Jan 2001 09:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRAYOxK>; Thu, 25 Jan 2001 09:53:10 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:3854 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129101AbRAYOxD>;
	Thu, 25 Jan 2001 09:53:03 -0500
Date: Thu, 25 Jan 2001 15:52:55 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATE] Zerocopy, last one today I promise :-)
In-Reply-To: <14960.13645.936452.235135@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101251540001.30299-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, David S. Miller wrote:
> This does show that not too many people are testing this all that
> thoroughly :-) Basically, any sys_sendfile() over TCP using a network
> card other than loopback/3c59x/sunhme/acenic would fail with -EFAULT
> or even worse a kernel crash depending upon architecture.

You may have said it before, but since you're the one who wants it tested,
I'm sure you're happy to repeat it, right? :-)

I understand from your comment that you want people to run it on all kinds
of hardware, both with and without hw checksumming, but how do you want us
to test it?  Is "my computer works as usual with this patch included" what
you are looking for, or do you want us to run specific tests or
benchmarks?

Should I get a speed increase in a normal TCP session, or do I have to use
sendfile to see any change?  Of course, stability is the most important
factor right now, but it would be nice if I will get a performance boost
from my old tired P90.  Right now it peaks at about 40 Mb/s for TCP.

/Tobias, a soon to be zerocopy patch tester

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
