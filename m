Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130199AbQJaEbV>; Mon, 30 Oct 2000 23:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130201AbQJaEbC>; Mon, 30 Oct 2000 23:31:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45441 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130199AbQJaEa6>;
	Mon, 30 Oct 2000 23:30:58 -0500
Date: Mon, 30 Oct 2000 20:16:52 -0800
Message-Id: <200010310416.UAA05485@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: caperry@edolnx.net
CC: linux-kernel@vger.kernel.org
In-Reply-To: <39FE5E75.91BEBD0@edolnx.net> (message from Carl Perry on Mon, 30
	Oct 2000 23:53:57 -0600)
Subject: Re: Is IPv4 totally broken in 2.4-test
In-Reply-To: <39FE5C09.F1B13725@edolnx.net> <200010310404.UAA05392@pizda.ninka.net> <39FE5E75.91BEBD0@edolnx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 30 Oct 2000 23:53:57 -0600
   From: Carl Perry <caperry@edolnx.net>

   What exactly does "Explicit Congestion Notification" do?

It's a protocol extension by which routers can tell clients
about the onset of congestion before the routers stops to drop
that client's packets.

Unfortunately, a widely deployed firewall product made by Cisco and
used at most of the large web sites block packets that make use
of ECN.  They have fixed the bug, but I honestly don't expect these
sites to install the fix any time soon no matter how much the Cisco
folks tell me that such sites are "likely to".

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
