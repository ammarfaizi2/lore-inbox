Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129207AbRBBFi4>; Fri, 2 Feb 2001 00:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129285AbRBBFiq>; Fri, 2 Feb 2001 00:38:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17024 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129240AbRBBFig>;
	Fri, 2 Feb 2001 00:38:36 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14970.18319.991981.729662@pizda.ninka.net>
Date: Thu, 1 Feb 2001 21:37:19 -0800 (PST)
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: [UPDATE] Zerocopy patch of the day...
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the usual spot:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.1-2.diff.gz

Changes:

1) Merge in 3c59x update from Andrew Morton.  I hope Andrew won't
   mind if people who see problems due to these changes at least
   CC: him on bug reports? :-)

2) Correct receive buffer space checks during direct user
   copies.

3) Correct returning of errors in datagram wait_for_packet(),
   cures DoS discovered with AF_UNIX sockets.

And yes, before Mr. Wedgewood asks, the generic fixes (#2 and
#3) will be sent to Linus seperately when he returns from NYC.
:-)

I will soon start keeping a real ChangeLog.zerocopy file going at the
same place you get the patches from.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
