Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRAXSFV>; Wed, 24 Jan 2001 13:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131492AbRAXSFL>; Wed, 24 Jan 2001 13:05:11 -0500
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:43528 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S131412AbRAXSFG>; Wed, 24 Jan 2001 13:05:06 -0500
Date: Wed, 24 Jan 2001 18:05:02 +0000 (GMT)
From: Tim Fletcher <tim@parrswood.manchester.sch.uk>
To: Daniel Phillips <phillips@innominate.de>
cc: Shawn Starr <Shawn.Starr@Home.net>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at slab.c:1542!(2.4.1-pre9)
In-Reply-To: <3A6ED16E.E8343678@innominate.de>
Message-ID: <Pine.LNX.4.30.0101241803290.30141-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > kernel BUG at slab.c:1542!
>
> The kernel should never oops, no matter what user space does to it.

What ever a none privilaged user space apps does witness:

root@localhost# dd if=/dev/random of=/dev/mem

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
 irc: Night-Shade on quakenet      ^^-^^

Justice is incidental to law and order.
                -- J. Edgar Hoover

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
