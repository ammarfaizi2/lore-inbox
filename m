Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130994AbQKGEny>; Mon, 6 Nov 2000 23:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbQKGEnp>; Mon, 6 Nov 2000 23:43:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22657 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130994AbQKGEng>;
	Mon, 6 Nov 2000 23:43:36 -0500
Date: Mon, 6 Nov 2000 20:29:14 -0800
Message-Id: <200011070429.UAA01723@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: jordy@napster.com
CC: kuznet@ms2.inr.ac.ru, ak@muc.de, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A077AB9.74FE8BF2@napster.com> (message from Jordan Mendelson on
	Mon, 06 Nov 2000 19:44:57 -0800)
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A076701.F437F88B@napster.com> <3A077AB9.74FE8BF2@napster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date:   Mon, 06 Nov 2000 19:44:57 -0800
   From: Jordan Mendelson <jordy@napster.com>

   Just some updates. This problem does not appear to happen under
   2.2.16.  The dump for 2.2.16 is almost the same except we send an
   mss back of 536 and not 1460 (remote mtu vs local mtu).

MSS advertized makes no difference, it controls not what sized
payloads we send, which is determined in this case by PMTU and thus
both Linux 2.2.x and 2.4.x send equally sized limited packets.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
