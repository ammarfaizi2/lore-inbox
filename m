Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129147AbQKGHnG>; Tue, 7 Nov 2000 02:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129802AbQKGHm4>; Tue, 7 Nov 2000 02:42:56 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58754 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129147AbQKGHmu>;
	Tue, 7 Nov 2000 02:42:50 -0500
Date: Mon, 6 Nov 2000 23:27:54 -0800
Message-Id: <200011070727.XAA02574@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: jordy@napster.com
CC: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <3A07B01A.1E70EE20@napster.com> (message from Jordan Mendelson on
	Mon, 06 Nov 2000 23:32:42 -0800)
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net> <3A07A4B0.A7E9D62@napster.com> <200011070656.WAA02435@pizda.ninka.net> <3A07AC45.DCC961FF@napster.com> <200011070712.XAA02511@pizda.ninka.net> <3A07B01A.1E70EE20@napster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 06 Nov 2000 23:32:42 -0800
   From: Jordan Mendelson <jordy@napster.com>

   Ok, but why doesn't 2.2.16 exhibit this behavior?

   We've had reports from quite a number of people complaining about
   this and I'm fairly certain not all of them are from Earthlink.

The only thing different is that 2.2.x is packetizing the write()
system calls on the server differently, otherwise there is no
difference whatsoever.

What 2.4.x is doing is completely legal.  Really, even if not all of
these people are from Earthlink (well, you should see if this is for
certain) they may all be using the same buggy terminal server at these
different ISPs.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
