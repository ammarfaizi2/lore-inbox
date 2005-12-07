Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbVLGTxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbVLGTxZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbVLGTxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:53:25 -0500
Received: from witte.sonytel.be ([80.88.33.193]:4789 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1030329AbVLGTxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:53:24 -0500
Date: Wed, 7 Dec 2005 20:53:03 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Rik van Riel <riel@redhat.com>,
       Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux in a binary world... a doomsday scenario
In-Reply-To: <1133981708.2869.54.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.62.0512072049110.24915@pademelon.sonytel.be>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
 <20051205121851.GC2838@holomorphy.com> <20051206011844.GO28539@opteron.random>
 <1133857767.2858.25.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.63.0512071337560.17172@cuia.boston.redhat.com>
 <Pine.LNX.4.58.0512071041420.17648@shark.he.net> <1133981708.2869.54.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Arjan van de Ven wrote:
> > Such lists could tell us not only which devices work (are
> > supported with open source drivers) but also which devices
> > are not supported and hence may need attention.
> > 
> > There has been some discussion about OSDL attempting to do this.
> 
> the biggest pitfal by having this done by a commercial entity or an
> entity with commercial funding is that there is a LOT of pressure to
> call things with binary drivers also certified/working. 
> It has to be an entity that can resist that pressure; if OSDL can,
> great. But their funding is partially from sources that will try to put
> that pressure on I suspect...
> So I would almost rather have a separate "kicked off and supported by
> OSDL" organisation with its own charter than have OSDL do it itself. I
> can imagine OSDL feeling the same as well ...

What about linux/Documentation/, which is maintained by us (as in `the
community', not by `commercial entity that can be pressured')?

At least for a `positive' lists it's not that difficult: if the driver is in
the tree, just add the supported hardware to the list in linux/Documentation/.

Whether we want to put a `negative' list there as well is another question.
Perhaps some form of `to do' or `drivers wanted' list?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
