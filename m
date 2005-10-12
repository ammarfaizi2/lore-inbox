Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVJLFyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVJLFyO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 01:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVJLFyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 01:54:14 -0400
Received: from witte.sonytel.be ([80.88.33.193]:24285 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932465AbVJLFyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 01:54:14 -0400
Date: Wed, 12 Oct 2005 07:54:01 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Hareesh Nagarajan <hnagar2@gmail.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, davem@redhat.com
Subject: Re: [PATCH] Trivial patch to remove list member from struct tcx_par
 in drivers/video/tcx.c
In-Reply-To: <434C654C.8020400@gmail.com>
Message-ID: <Pine.LNX.4.62.0510120747420.27369@numbat.sonytel.be>
References: <434B23CB.7000609@gmail.com> <Pine.LNX.4.62.0510111947100.20510@numbat.sonytel.be>
 <434C654C.8020400@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2005, Hareesh Nagarajan wrote:
> Geert Uytterhoeven wrote:
> > On Mon, 10 Oct 2005, Hareesh Nagarajan wrote:
> > > This patch removes the list_head member 'list' from struct tcx_par in the
> > > file
> > > drivers/video/tcx.c among other trivial cleanups. The member 'list' is
> > > never
> > > used. It turns out that other frame buffer code like cg14.c, leo.c, bw2.c,
> > > etc. (in drivers/video) seem to have the same extra list_head member in
> > > their
> > > respective *_par structures.
> > 
> > What about the other changes you made (cfr. below)?
> 
> Please pardon my ignorance, but what does 'cfr.' mean?

cfr. = confer (Latin) = like

> Must I go ahead and create a patch which removes the extra list_head member in
> the *_par structures?

If it's unused, please go ahead.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
