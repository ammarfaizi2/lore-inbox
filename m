Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263365AbRFKDSY>; Sun, 10 Jun 2001 23:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263370AbRFKDSE>; Sun, 10 Jun 2001 23:18:04 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:60122 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S263365AbRFKDRz>; Sun, 10 Jun 2001 23:17:55 -0400
Date: Sun, 10 Jun 2001 22:17:46 -0500
From: "Glenn C. Hofmann" <hofmanng@swbell.net>
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <15140.5762.589629.252904@pizda.ninka.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "David S. Miller" <davem@redhat.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Ben LaHaise <bcrl@redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Reply-to: ghofmann@pair.com
Message-id: <3B23F20A.22574.10AD93@localhost>
MIME-version: 1.0
X-Mailer: Pegasus Mail for Win32 (v3.12c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
In-Reply-To: <3B23A4BB.7B4567A3@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have, as was suggested, built as a module, and get unresolved symbol do_softirq, so 
this appears to be another problem in this driver with 2.4.6-pre2.  If I can help in any 
way, please let me know, although I am by no means a programmer, just a tester.  
Thanks.

Glenn C. Hofmann


On 10 Jun 2001, at 17:53 David S. Miller wrote:

> 
> Jeff Garzik writes:
>  > > [note I've not found anything in 2.4.5 where netif_carrier_ok prevents
>  > > the net layers queueing packets for an interface, and forwarding them
>  > > on for transmission].
>  > 
>  > we want netif_carrier_{on,off} to emit netlink messages.  I don't know
>  > how DaveM would feel about such getting implemented in 2.4.x though,
>  > even if well tested.
> 
> If someone sent me patches which did this (and minded the
> restrictions, if any, this adds to the execution contexts in
> which the carrier on/off stuff can be invoked) I would consider
> the patch seriously for 2.4.x
> 
> Later,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


