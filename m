Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130971AbRAaAbu>; Tue, 30 Jan 2001 19:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130092AbRAaAbk>; Tue, 30 Jan 2001 19:31:40 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:5382 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S130966AbRAaAb0>; Tue, 30 Jan 2001 19:31:26 -0500
Date: Wed, 31 Jan 2001 13:31:23 +1300
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
Message-ID: <20010131133123.A7875@metastasis.f00f.org>
In-Reply-To: <3A76B72D.2DD3E640@uow.edu.au> <3A728475.34CF841@uow.edu.au> <3A726087.764CC02E@uow.edu.au> <20010126222003.A11994@vitelus.com> <14966.22671.446439.838872@pizda.ninka.net> <14966.47384.971741.939842@pizda.ninka.net> <3A76D6A4.2385185E@uow.edu.au> <20010131064911.B7244@metastasis.f00f.org> <14967.15765.553667.802101@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14967.15765.553667.802101@pizda.ninka.net>; from davem@redhat.com on Tue, Jan 30, 2001 at 02:17:57PM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 02:17:57PM -0800, David S. Miller wrote:

    8.5MB/sec sounds like half-duplex 100baseT.

No; I'm 100% its  FD; HD gives 40k/sec TCP because of collisions and
such like.

    Positive you are running at full duplex all the way to the
    netapp, and if so how many switches sit between you and this
    netapp?

It's FD all the way (we hardwire everything to 100-FD and never trust
auto-negotiate); I see no errors or such like anywhere.

There are ... <pause> ... 3 switches between four switches in
between, mostly linked via GE. I'm not sure if latency might be an
issue here, is it was critical I can imagine 10 km of glass might be
a problem but it's not _that_ far...


  --cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
