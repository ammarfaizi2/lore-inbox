Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267237AbTBFOPq>; Thu, 6 Feb 2003 09:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267257AbTBFOPq>; Thu, 6 Feb 2003 09:15:46 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:57008 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S267237AbTBFOPp>;
	Thu, 6 Feb 2003 09:15:45 -0500
Date: Thu, 6 Feb 2003 15:23:35 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Willy Tarreau <willy@w.ods.org>
cc: Larry McVoy <lm@work.bitmover.com>, Ben Collins <bcollins@debian.org>,
       Andrea Arcangeli <andrea@e-mind.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
In-Reply-To: <20030206060223.GB6859@alpha.home.local>
Message-ID: <Pine.GSO.4.21.0302061522390.3301-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2003, Willy Tarreau wrote:
> On Wed, Feb 05, 2003 at 08:37:37PM -0800, Larry McVoy wrote:
> > > You may want to enable mod_deflate, and then scripts can easily make use
> > > of gzip compressed data. May not be an end-all, but something to
> > > consider.
> > 
> > Gzip will give 4:1 what these scripts are doing is more like 1000:1.  
> > So gzipping the data gets you down to 250:1.  That's still way more
> > bandwidth, way too much to be acceptable.
> 
> Larry, would it be acceptable/possible to regularly push some data/metadata
> to sites like kernel.org that people already consult for kernel development ?
> This way, Andrea's tool would only have to check kernel.org, and not bkbits.net.
> 
> Another solution is to fetch from a reverse proxy-cache on a high-bandwidth
> site, provided that we know what to cache, of course. This could even reduce
> your current HTTP usage since nearly everything should be cacheable for a very
> long period.

Can't all information be extracted from the bk-commits* mailing lists postings?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

