Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266524AbUGUPtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266524AbUGUPtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 11:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUGUPtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 11:49:15 -0400
Received: from witte.sonytel.be ([80.88.33.193]:63899 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266524AbUGUPtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 11:49:03 -0400
Date: Wed, 21 Jul 2004 17:48:54 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olaf Hering <olh@suse.de>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackeras <paulus@samba.org>
Subject: Re: reserve legacy io regions on powermac
In-Reply-To: <20040721145649.GA439@suse.de>
Message-ID: <Pine.GSO.4.58.0407211746200.8147@waterleaf.sonytel.be>
References: <20040721091249.GA1336@suse.de> <1090421466.2002.24.camel@gaston>
 <20040721145649.GA439@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2004, Olaf Hering wrote:
>  On Wed, Jul 21, Benjamin Herrenschmidt wrote:
> > On Wed, 2004-07-21 at 05:12, Olaf Hering wrote:
> > > I think the simplest fix for 2.6 is a request_region of the problematic
> > > areas.
> >
> > Note that this is still all workarounds... Nothing prevents you (and some
> > people actually do that) to put a PCI card with legacy serial ports on it
> > inside a pmac....
>
> Sure, but will that use the same io ports? I dont have one to verify it.

If it's a `clean' PCI card, it will use the PCI BARs, and there's no problem.

> How does it look on a pccard modem?

PCMCIA is hidden ISA. You can e.g. put the PCMCIA CD-ROM drive that came with
my Vaio (it behaves like a legacy second IDE card) in a Mac laptop.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
