Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRBJAay>; Fri, 9 Feb 2001 19:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129763AbRBJAap>; Fri, 9 Feb 2001 19:30:45 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:254 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S129584AbRBJAaf>; Fri, 9 Feb 2001 19:30:35 -0500
Date: Fri, 9 Feb 2001 16:29:49 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Scott Laird <laird@internap.com>
cc: George <greerga@entropy.muc.muohio.edu>,
        Peter Samuelson <peter@cadcamlab.org>,
        Bernd Eckenfels <inka-user@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Request: increase in PCI bus limit
In-Reply-To: <Pine.LNX.4.31.0101311243340.13278-100000@lairdtest1.internap.com>
Message-ID: <Pine.LNX.4.21.0102091628570.26669-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Scott Laird wrote:
> On Wed, 31 Jan 2001, George wrote:
> >   Also account for anything else funny in the system.
> >
> > Then panic on boot if they're wrong (sort of like processor type).
> 
> Where do cards with PCI-PCI bridges, like multiport PCI ethernet cards,
> fit into this?  I can easily add 3 or 4 extra busses into a box just by
> grabbing a couple extra Intel dual-port Ethernet cards.

Notice the 'also account for anything funny' line. Multiport ethernet
cards IMO fall under this category.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
