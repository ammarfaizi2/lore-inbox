Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269420AbUINPBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269420AbUINPBy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269381AbUINO74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:59:56 -0400
Received: from mail1.smlink.com ([212.143.64.225]:38001 "EHLO
	smmail.server.smlink.com") by vger.kernel.org with ESMTP
	id S269392AbUINO44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:56:56 -0400
Date: Tue, 14 Sep 2004 17:59:49 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
To: David Lloyd <dmlloyd@tds.net>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97  
 patch)
Message-ID: <20040914175949.6b59a032@sashak.lan>
In-Reply-To: <Pine.LNX.4.60.0409131526050.29875@tomservo.workpc.tds.net>
References: <200409111850.i8BIowaq013662@harpo.it.uu.se>
	<20040912011128.031f804a@localhost>
	<Pine.LNX.4.60.0409131526050.29875@tomservo.workpc.tds.net>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2004 15:56:58.0273 (UTC) FILETIME=[7710E910:01C49A73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 15:26:35 -0500 (CDT)
David Lloyd <dmlloyd@tds.net> wrote:

> On Sun, 12 Sep 2004, SashaK wrote:
> 
> > On Sat, 11 Sep 2004 20:50:58 +0200 (MEST)
> > Mikael Pettersson <mikpe@csd.uu.se> wrote:
> >
> >> No, I meant the 'slamr' kernel driver module, which is
> >> built from a big binary-only library (amrlibs.o) and
> >> a small amount of kernel glue source code. As long as
> >> amrlibs.o is distributed only as a 32-bit x86 binary,
> >> I won't be able to use it with a 64-bit amd64 kernel.
> >
> > This is exactly that was discussed - 'slamr' is going to be replaced
> > by ALSA drivers. I don't know which modem you have, but recent ALSA
> > driver (CVS version) already supports ICH, SiS, NForce
> > (snd-intel8x0m), ATI IXP (snd-atiixp-modem) and VIA
> > (snd-via82xx-modem) AC97 modems.
> 
> Are these all motherboard-chipset modems, or is there such a thing as
> an AC97-based PCI modem card?

Such modems also exist (AC97 controller + MC97 codec + DAA), but less
popular (especially with laptops there modem are mostly used).

Sasha.

