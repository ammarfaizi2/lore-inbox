Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271153AbTHHALC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 20:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271154AbTHHALC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 20:11:02 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16566 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S271153AbTHHAK6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 20:10:58 -0400
Date: Fri, 8 Aug 2003 02:10:19 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ide-tape broken (was Re: [PATCH] use ide-identify.h, fix endian
 bug)
In-Reply-To: <200308072341.h77NfeF4025095@harpo.it.uu.se>
Message-ID: <Pine.SOL.4.30.0308080205490.24371-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Aug 2003, Mikael Pettersson wrote:

> On Thu, 7 Aug 2003 22:51:31 +0200 (MET DST), Bartlomiej Zolnierkiewicz wrote:
> >On Thu, 7 Aug 2003 Andries.Brouwer@cwi.nl wrote:
> >
> >> Given ide-identify.h, we can simplify ide-floppy.c and ide-tape.c a lot.
> >> In fact ide-tape.c was broken on big-endian machines.
> >> (Unfortunately much more is broken that was fixed here,
> >> ide-tape.c is not in a good shape today.)
> >
> >ide-tape is broken because nobody cares, so I don't care too
> >(was broken even before).  It needs rewrite and testing.
> >
> >So once again if anybody cares and has hardware to test,
> >please contact me and I will try fix it.
> >
> >Until then I don't touch it et all and consider it obsoleted.
>
> I used to use the ide-tape driver for my Seagate STT8000A,
> but its prolonged brokenness in 2.5 (caused initially by the
> bio changes) made me switch to ide-scsi + st instead since
> that at least _works_.
>
> I can test updates as they hit Linus 2.6-releases, but frankly

Great.

> I'd rather use ide-scsi+st or a new clean ATAPI tape driver
> than ide-tape.c. (I've studied ide-tape.c. It reeks of poor

"new clean ATAPI tape drive" == the one yet to be written?

> coding style, kludges for Onstream, and an over-engineered
> buffering scheme. And it's known to have problems with DMA.)

So you are familiar with the code, cool. ;-)

I will try to simplify ide-tape.c as much as possible.

--bartlomiej

