Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132652AbRA3WT6>; Tue, 30 Jan 2001 17:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132651AbRA3WTs>; Tue, 30 Jan 2001 17:19:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2694 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132652AbRA3WTg>;
	Tue, 30 Jan 2001 17:19:36 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14967.15765.553667.802101@pizda.ninka.net>
Date: Tue, 30 Jan 2001 14:17:57 -0800 (PST)
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <20010131064911.B7244@metastasis.f00f.org>
In-Reply-To: <3A76B72D.2DD3E640@uow.edu.au>
	<3A728475.34CF841@uow.edu.au>
	<3A726087.764CC02E@uow.edu.au>
	<20010126222003.A11994@vitelus.com>
	<14966.22671.446439.838872@pizda.ninka.net>
	<14966.47384.971741.939842@pizda.ninka.net>
	<3A76D6A4.2385185E@uow.edu.au>
	<20010131064911.B7244@metastasis.f00f.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Wedgwood writes:
 > What server are you using here? Using NetApp filers I don't see
 > anything like this, probably only 8.5MB/s at most and this number is
 > fairly noisy.

8.5MB/sec sounds like half-duplex 100baseT.  Positive you are running
at full duplex all the way to the netapp, and if so how many switches
sit between you and this netapp?

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
