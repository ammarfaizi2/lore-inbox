Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129883AbQKGHaB>; Tue, 7 Nov 2000 02:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130555AbQKGH3v>; Tue, 7 Nov 2000 02:29:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50562 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129883AbQKGH3e>;
	Tue, 7 Nov 2000 02:29:34 -0500
Date: Mon, 6 Nov 2000 23:14:35 -0800
Message-Id: <200011070714.XAA02517@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ak@suse.de
CC: jordy@napster.com, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <20001107081604.A2410@gruyere.muc.suse.de> (message from Andi
	Kleen on Tue, 7 Nov 2000 08:16:04 +0100)
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net> <20001107080342.A2159@gruyere.muc.suse.de> <200011070659.WAA02448@pizda.ninka.net> <20001107081604.A2410@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 7 Nov 2000 08:16:04 +0100
   From: Andi Kleen <ak@suse.de>

   Hmm. One of these weird bandwidth limiters again?

In a more recent mail, TCP header compression in Win98 or Earthlink's
terminal servers have become the current prime suspect. :-)

   The RTT is lower than 2.2's initial 3s RTT, so 2.2 would never see
   it.

The 240 traces are using an RTT of 3s (look at the time difference of
the first retransmit), so this is not it.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
