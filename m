Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263494AbTHXMaQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTHXMaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:30:16 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:39602 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263494AbTHXMaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:30:12 -0400
Date: Sun, 24 Aug 2003 14:29:07 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] macide (was: Re: Linux 2.6.0-test4)
In-Reply-To: <20030824132058.A16763@infradead.org>
Message-ID: <Pine.GSO.4.21.0308241426170.14814-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Aug 2003, Christoph Hellwig wrote:
> On Sun, Aug 24, 2003 at 01:51:20PM +0200, Geert Uytterhoeven wrote:
> > On Fri, 22 Aug 2003, Linus Torvalds wrote:
> > > Bartlomiej Zolnierkiewicz:
> > >   o ide: disk geometry/capacity cleanups
> > >   o ide: always store disk capacity in u64
> > 
> > You forgot to update the Macintosh IDE driver:
> 
> Btw, what's the state of mac68k (and the other m68k subarches) on
> 2.6?

Amiga, Sun-3/3x and probably Q40/Q60 are working, except for some SCSI drivers.
Other subarches are in a worse shape.

In general, 2.6.0-test4 on m68k isn't that far from 2.4.22-rc3, except for some
SCSI breakage.

You can check out the status at http://linux-m68k-cvs.apia.dhs.org/~geert/.
The patch pages are usually up-to-date, the feature status pages aren't (e.g.
basic m68k support got fixed a few weeks ago).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

