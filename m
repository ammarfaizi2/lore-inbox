Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTEMTjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 15:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbTEMTjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 15:39:05 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:60924 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262328AbTEMTjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:39:04 -0400
Date: Tue, 13 May 2003 21:51:06 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 must-fix list, v2
In-Reply-To: <20030513163854.A27407@infradead.org>
Message-ID: <Pine.GSO.4.21.0305132140200.13355-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, Christoph Hellwig wrote:
> On Tue, May 13, 2003 at 02:57:08PM +0100, Alan Cox wrote:
> > SH3/SH3-64 need resynching, as do some other ports. No impact on
> > mainstream platforms hopefully
> 
> That brings up another issue:  what ports do regularly work with 2.5
> mainline?  I've been working with David to get all those core changes ia64
> needs (and there's still a lot) sorted out so maybe 2.6 will work out of
> the box.  I guess some other arches (parisc, mips?) will need similar
> work.

Just FYI... For the m68k port, I have ca. 150 KiB of patches in Linus' INBOX
(if they're still there, mainly irqreturn_t stuff), and about 100 KiB of
postponed stuff I'm not gonna send (i.e. things that are not ready for
submission yet, or that are too controversial).

Amiga (non-SCSI) and Q40/Q60 should work fairly well in 2.5.x, except that
early userspace (launching of /sbin/init) got broken in 2.5.67 or 2.5.68.

For comparison, 2.4.x has no stuff in Marcelo's INBOX, and about the same 100
KiB of postponed stuff. Not counting Michael Müller's new TekXpress port, which
is not even in Linux/m68k CVS (http://linux-m68k-cvs.apia.dhs.org/) yet.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

