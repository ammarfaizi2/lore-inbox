Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRASG6B>; Fri, 19 Jan 2001 01:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129901AbRASG5w>; Fri, 19 Jan 2001 01:57:52 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:22285 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129733AbRASG5t>; Fri, 19 Jan 2001 01:57:49 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200101190657.f0J6vWe32701@devserv.devel.redhat.com>
Subject: Re: Is sendfile all that sexy?
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 19 Jan 2001 01:57:32 -0500 (EST)
Cc: zippel@fh-brandenburg.de (Roman Zippel),
        adilger@turbolinux.com (Andreas Dilger),
        R.E.Wolff@bitwizard.nl (Rogier Wolff), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101181700350.8732-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 18, 2001 05:14:01 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which in turn implies that the non-disk target hardware has to be able to
> have a PCI-mapped memory buffer for the source or the destination, AND
> they have to be able to cope with the fact that the data you get off the
> disk will have to be the raw data at 512-byte granularity.

And that the chipset gets it right. Which is a big assumption as tv card
driver folks can tell you
The pcipci stuff in quirks is only a beginning alas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
