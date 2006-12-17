Return-Path: <linux-kernel-owner+w=401wt.eu-S1752410AbWLQK51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbWLQK51 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 05:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbWLQK51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 05:57:27 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:38260 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752408AbWLQK50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 05:57:26 -0500
Date: Sun, 17 Dec 2006 11:57:24 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <20061214173827.GC3452@infradead.org>
Message-ID: <Pine.LNX.4.62.0612171155590.27120@pademelon.sonytel.be>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
 <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
 <458171C1.3070400@garzik.org> <Pine.LNX.4.64.0612140855250.5718@woody.osdl.org>
 <20061214170841.GA11196@tuatara.stupidest.org> <20061214173827.GC3452@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006, Christoph Hellwig wrote:
> On Thu, Dec 14, 2006 at 09:08:41AM -0800, Chris Wedgwood wrote:
> > On Thu, Dec 14, 2006 at 09:03:57AM -0800, Linus Torvalds wrote:
> > 
> > > I actually think the EXPORT_SYMBOL_GPL() thing is a good thing, if
> > > done properly (and I think we use it fairly well).
> > >
> > > I think we _can_ do things where we give clear hints to people that
> > > "we think this is such an internal Linux thing that you simply
> > > cannot use this without being considered a derived work".
> > 
> > Then why not change the name to something more along those lines?
> 
> Yes, EXPORT_SYMBOL_INTERNAL would make a lot more sense.

I find all those names confusing. If these special symbols are
GPL/INTERNAL/WHATEVER, what are the other exported symbols?

GPL -> Non-GPL?
INTERNAL -> External?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
