Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRAJD1o>; Tue, 9 Jan 2001 22:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130548AbRAJD1f>; Tue, 9 Jan 2001 22:27:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21387 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129764AbRAJD1Q>;
	Tue, 9 Jan 2001 22:27:16 -0500
Date: Tue, 9 Jan 2001 19:09:59 -0800
Message-Id: <200101100309.TAA16576@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: dean-list-linux-kernel@arctic.org
CC: mingo@elte.hu, riel@conectiva.com.br, hch@caldera.de, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101091916210.10428-100000@twinlark.arctic.org>
	(message from dean gaudet on Tue, 9 Jan 2001 19:18:53 -0800 (PST))
Subject: Re: storage over IP (was Re: [PLEASE-TESTME] Zerocopy networking
 patch, 2.4.0-1)
In-Reply-To: <Pine.LNX.4.30.0101091916210.10428-100000@twinlark.arctic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 9 Jan 2001 19:18:53 -0800 (PST)
   From: dean gaudet <dean-list-linux-kernel@arctic.org>

   - NIC DMAs packet to memory
   - CPU reads headers from memory, figures out it's NFS
   - CPU copies data bytes from packet image in memory to pagecache

Yes, this is precisely what happens in the NFS client with
the zerocopy patches applied.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
