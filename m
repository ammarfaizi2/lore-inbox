Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132095AbRANK4f>; Sun, 14 Jan 2001 05:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132130AbRANK4Z>; Sun, 14 Jan 2001 05:56:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51866 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132095AbRANK4P>;
	Sun, 14 Jan 2001 05:56:15 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14945.34208.281500.226085@pizda.ninka.net>
Date: Sun, 14 Jan 2001 02:55:28 -0800 (PST)
To: Andi Kleen <ak@suse.de>
Cc: Igmar Palsenberg <i.palsenberg@jdimedia.nl>,
        Harald Welte <laforge@gnumonks.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 + iproute2
In-Reply-To: <20010114115215.A22550@gruyere.muc.suse.de>
In-Reply-To: <14945.26991.35849.95234@pizda.ninka.net>
	<Pine.LNX.4.30.0101141013080.16469-100000@jdi.jdimedia.nl>
	<14945.28354.209720.579437@pizda.ninka.net>
	<20010114115215.A22550@gruyere.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > In my opinion (rt)netlink would benefit a lot from introducing 5-10
 > new errnos and possibly a new socket option to get a string/number
 > with the exact error.

Introducing 5-10 new errnos just for rtnetlink is a big waste when we
already have socket extended errors which are perfect for this
purpose.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
