Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129557AbRABXP4>; Tue, 2 Jan 2001 18:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130480AbRABXPq>; Tue, 2 Jan 2001 18:15:46 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:1550 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129557AbRABXPh> convert rfc822-to-8bit; Tue, 2 Jan 2001 18:15:37 -0500
Date: Tue, 2 Jan 2001 14:44:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dan Hollis <goemon@anime.net>
cc: David Woodhouse <dwmw2@infradead.org>,
        Hakan Lennestal <hakanl@cdt.luth.se>,
        Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts.... 
In-Reply-To: <Pine.LNX.4.30.0101021441290.15631-100000@anime.net>
Message-ID: <Pine.LNX.4.10.10101021444010.1037-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id OAA27423
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2001, Dan Hollis wrote:

> On Tue, 2 Jan 2001, David Woodhouse wrote:
> > It's a combination of chipset and drive that causes the problems. I've
> > been using ata66 with the same controller on a different drive
> > (FUJITSU MPE3136AT) for some time now, and it's been rock solid. It's only
> > the IBM DTLA drive that's been a problem on this controller.
> 
> Maxtor has problems with hpt366 also.
> 
> > Highpoint made changes in their 1.26¹ BIOS to correctly support the IBM
> > DTLA drives. If we can get access to information about what they had to
> > change, we ought to be able to get it to work on those drives reliably.
> 
> Too bad Maxtor is still broken with hpt366...
> 
> Also, using CDROM on hpt366 is recipe for disaster...

Does the Maxtor and/or CDROM problems have anything to do with udma66? Ie
if you can test, can you please check whether it's ok when they are added
to the blacklists (or if udma66 is just disabled by default)?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
