Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTICLDH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 07:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTICLDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 07:03:07 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:9899 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261863AbTICLDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 07:03:05 -0400
Date: Wed, 3 Sep 2003 13:02:32 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Brown, Len" <len.brown@intel.com>
cc: Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: RE: Scaling noise
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com>
Message-ID: <Pine.GSO.4.21.0309031301380.6985-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Brown, Len wrote:
> > Latency is not bandwidth.
> 
> Bingo.
> 
> The way to address memory latency is by increasing bandwidth and
> increasing parallelism to use it -- thus amortizing the latency.  HT is
> one of many ways to do this.  If systems are to grow faster at a rate
> better than memory speeds, then plan on more parallelism, not less.

More parallelism usually means more data to process, hence more bandwidth is
needed => back to where we started.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

