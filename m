Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131496AbRAaAvo>; Tue, 30 Jan 2001 19:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131948AbRAaAve>; Tue, 30 Jan 2001 19:51:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11401 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131819AbRAaAv2>;
	Tue, 30 Jan 2001 19:51:28 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14967.24592.679296.55231@pizda.ninka.net>
Date: Tue, 30 Jan 2001 16:45:04 -0800 (PST)
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <20010131133123.A7875@metastasis.f00f.org>
In-Reply-To: <3A76B72D.2DD3E640@uow.edu.au>
	<3A728475.34CF841@uow.edu.au>
	<3A726087.764CC02E@uow.edu.au>
	<20010126222003.A11994@vitelus.com>
	<14966.22671.446439.838872@pizda.ninka.net>
	<14966.47384.971741.939842@pizda.ninka.net>
	<3A76D6A4.2385185E@uow.edu.au>
	<20010131064911.B7244@metastasis.f00f.org>
	<14967.15765.553667.802101@pizda.ninka.net>
	<20010131133123.A7875@metastasis.f00f.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Wedgwood writes:
 > There are ... <pause> ... 3 switches between four switches in
 > between, mostly linked via GE. I'm not sure if latency might be an
 > issue here, is it was critical I can imagine 10 km of glass might be
 > a problem but it's not _that_ far...

Other than this, I don't know what to postulate.  Really,
most reports and my own experimentation (directly connected
Linux knfsd to 2.4.x nfs client) supports the fact that our
client can saturate 100baseT rather fully.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
