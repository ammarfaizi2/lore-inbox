Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbTLRT1d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 14:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbTLRT1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 14:27:33 -0500
Received: from intra.cyclades.com ([64.186.161.6]:61867 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265274AbTLRT0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 14:26:11 -0500
Date: Thu, 18 Dec 2003 17:05:06 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Hunold <hunold@convergence.de>
Subject: Re: [PATCH][2.4] change two annoying messages from framebuffer
 drivers
In-Reply-To: <Pine.GSO.4.58.0312151109460.16964@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.58L.0312181704310.23845@logos.cnet>
References: <3FD9BB4B.6040900@convergence.de> <Pine.GSO.4.58.0312151109460.16964@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Dec 2003, Geert Uytterhoeven wrote:

> On Fri, 12 Dec 2003, Michael Hunold wrote:
> > Two framebuffer drivers (clgenfb.c and hgafb.c), however, use KERN_ERR
> > to say that their particular card has *not* been found which is very
> > annoying.
> >
> > Especially the clgenfb.c driver simply says on bootup:
> >  >  Couldn't find PCI device
> > which can really confuse newbie users.
> >
> > The appended patch replaces two KERN_ERR with KERN_INFO and additionally
> > makes the clgen.c message more descriptive.
> >
> > Please apply, thanks!
>
> Patch looks OK to me, except that I would print `clgenfb' instead of `clgen'.

That looks sane.

Can you change it Michael?
