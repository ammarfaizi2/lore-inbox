Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbRANJOe>; Sun, 14 Jan 2001 04:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130196AbRANJOX>; Sun, 14 Jan 2001 04:14:23 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:61200 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S129716AbRANJOT>;
	Sun, 14 Jan 2001 04:14:19 -0500
Date: Sun, 14 Jan 2001 10:14:08 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
To: "David S. Miller" <davem@redhat.com>
cc: Igmar Palsenberg <i.palsenberg@jdimedia.nl>,
        Harald Welte <laforge@gnumonks.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 + iproute2
In-Reply-To: <14945.26991.35849.95234@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101141013080.16469-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > > You forgot to set CONFIG_IP_ADVANCED_ROUTER
>  >
>  > Nope. Still the same error after that one is set :
>  >
>  > CONFIG_IP_ADVANCED_ROUTER=y
>
> Try CONFIG_IP_MULTIPLE_TABLES.

Yep, that was the one..

we might want to consider changing the error the call gives in case
MULTIPLE_TABLES isn't set. -EINVAL is ugly, -ENOSYS should make the error
more clear..

> Later,
> David S. Miller
> davem@redhat.com


Thanx,

		Igmar


-- 

--
Igmar Palsenberg
JDI Media Solutions

Jansplaats 11
6811 GB Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
