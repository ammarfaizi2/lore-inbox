Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131048AbRAaUqd>; Wed, 31 Jan 2001 15:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131680AbRAaUqW>; Wed, 31 Jan 2001 15:46:22 -0500
Received: from lairdtest1.internap.com ([206.253.215.67]:56839 "EHLO
	lairdtest1.internap.com") by vger.kernel.org with ESMTP
	id <S131048AbRAaUqN>; Wed, 31 Jan 2001 15:46:13 -0500
Date: Wed, 31 Jan 2001 12:45:44 -0800 (PST)
From: Scott Laird <laird@internap.com>
To: George <greerga@entropy.muc.muohio.edu>
cc: Peter Samuelson <peter@cadcamlab.org>,
        Bernd Eckenfels <inka-user@lina.inka.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Request: increase in PCI bus limit
In-Reply-To: <Pine.LNX.4.30.0101311535130.24040-100000@entropy.muc.muohio.edu>
Message-ID: <Pine.LNX.4.31.0101311243340.13278-100000@lairdtest1.internap.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Jan 2001, George wrote:
>
> If someone says 1 bus, give them one bus.
>
> Just make the description say:
>   Add 1 for every PCI
>   Add 1 for every AGP
>   Add 1 for every CardBus
>   Also account for anything else funny in the system.
>
> Then panic on boot if they're wrong (sort of like processor type).

Where do cards with PCI-PCI bridges, like multiport PCI ethernet cards,
fit into this?  I can easily add 3 or 4 extra busses into a box just by
grabbing a couple extra Intel dual-port Ethernet cards.


Scott

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
