Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQLXQKv>; Sun, 24 Dec 2000 11:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129707AbQLXQKl>; Sun, 24 Dec 2000 11:10:41 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:3706 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129597AbQLXQKh>; Sun, 24 Dec 2000 11:10:37 -0500
Date: Sun, 24 Dec 2000 16:40:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001224164009.A8636@athlon.random>
In-Reply-To: <3A41DDB3.7E38AC7@uow.edu.au>, <3A41DDB3.7E38AC7@uow.edu.au>; <20001221161952.B20843@athlon.random> <3A4303AC.C635F671@uow.edu.au>, <3A4303AC.C635F671@uow.edu.au>; <20001222141929.A13032@athlon.random> <3A444CAA.4C5A7A89@uow.edu.au>, <3A444CAA.4C5A7A89@uow.edu.au>; <20001223191159.B29450@athlon.random> <3A454205.D33090A8@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A454205.D33090A8@uow.edu.au>; from andrewm@uow.edu.au on Sun, Dec 24, 2000 at 11:23:33AM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2000 at 11:23:33AM +1100, Andrew Morton wrote:
> ack.

This patch against 2.2.19pre3 should fix all races. (note that wait->flags
doesn't need to be initialized in the critical section in test1X too)

	ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.19pre3/wake-one-3

Comments?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
