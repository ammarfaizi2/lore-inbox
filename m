Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130880AbRAGMID>; Sun, 7 Jan 2001 07:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131153AbRAGMHx>; Sun, 7 Jan 2001 07:07:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18818 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130880AbRAGMHo>;
	Sun, 7 Jan 2001 07:07:44 -0500
Date: Sun, 7 Jan 2001 03:50:34 -0800
Message-Id: <200101071150.DAA01700@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: hps@tanstaafl.de
CC: linux-kernel@vger.kernel.org
In-Reply-To: <939kiq$11s$1@forge.intermeta.de> (hps@tanstaafl.de)
Subject: Re: [little bit OT] ip _IS_ _NOT_ ifconfig and route ! (was Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!))
In-Reply-To: <Pine.GSO.4.30.0101062253440.18916-100000@shell.cyberus.ca>, <200101070543.VAA24689@pizda.ninka.net> <939kiq$11s$1@forge.intermeta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Sun, 7 Jan 2001 11:40:10 +0000 (UTC)
   From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>

   As long as "man ip" on my machines returns "ip(7) - ip - Linux IPv4
   protocol implementation", using "ip" exclusively instead of
   ifconfig and route is IMHO not an option for anyone else than
   bleeding edge hackers and linux gurus.

As long as "man printf" gives me that damn shell command manpage, I
will not use printf in my C applications. :-))))  Yes, I do
understand, "ip" needs some more documentation perhaps.

Nobody has suggested getting rid of ifconfig, rather we have suggested
to implement it in terms of "ip" because, as you even mention, "ip" is
powerful and can do everything ifconfig can do thus ifconfig can be
implemented as a wrapper on top of "ip".

Nobody has suggested to use "ip" exclusively, you will not invoke "ip"
with the suggestion I am making.  Ifconfig indirectly will, but you
won't even notice nor should you care.  They will be packaged
together, so even that won't be an issue.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
