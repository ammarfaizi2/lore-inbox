Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129470AbQKHSvJ>; Wed, 8 Nov 2000 13:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129668AbQKHSu7>; Wed, 8 Nov 2000 13:50:59 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:32008 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129470AbQKHSur>; Wed, 8 Nov 2000 13:50:47 -0500
Date: Wed, 8 Nov 2000 19:50:41 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "J . A . Magallon" <jamagallon@able.es>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: continuing VM madness
In-Reply-To: <E13tZF5-0000EX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1001108193706.18297B-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Sadly it is not a bug but a VM misdesign (and people are just making
> > different workarounds that more or less work). I believe that this
> > solution will break again, as it happened in 2.2.15 and 2.2.16.
> 
> 2.2.15->16 was the major transition in getting stuff right. 2.2.18 should be
> pretty reasonable. With Andrea's additional patches its quite nice. If we
> add page aging then in theory it'll be as good as 2.2 but in practice who 
> knows

What about the possibility that kernel shoots processes when the machine
is receiving too much packets and runs out of atomic memory? It didn't
seem to go away in 2.2.16. 2.0 behaved correctly in this case.

Mikulas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
