Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132222AbQK3Gnt>; Thu, 30 Nov 2000 01:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132226AbQK3Gni>; Thu, 30 Nov 2000 01:43:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27141 "EHLO pizda.ninka.net")
        by vger.kernel.org with ESMTP id <S132222AbQK3Gnb>;
        Thu, 30 Nov 2000 01:43:31 -0500
Date: Wed, 29 Nov 2000 21:57:37 -0800
Message-Id: <200011300557.VAA03527@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: mes@capelazo.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10011292033380.27791-100000@lazo.capelazo.com>
        (message from Mark Sutton on Wed, 29 Nov 2000 20:53:32 -0800 (PST))
Subject: Re: TCP header bits set in reserved space
In-Reply-To: <Pine.GSO.4.10.10011292033380.27791-100000@lazo.capelazo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date:   Wed, 29 Nov 2000 20:53:32 -0800 (PST)
   From: Mark Sutton <mes@capelazo.com>
				 ^^
   This packet is never ACK'd by www.sun.com and the only difference I
   can see from one that is are these two bits. RFC793 says they must be zero.
   Is 793 still current? Has anyone else seen this?

ECN, RFC2481

Turn it off with /proc/sys/net/ipv4/tcp_ecn or tell Sun to update the
software running on their firewall.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
