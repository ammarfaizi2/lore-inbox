Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbTLQKId (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 05:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTLQKId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 05:08:33 -0500
Received: from witte.sonytel.be ([80.88.33.193]:45718 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264260AbTLQKIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 05:08:31 -0500
Date: Wed, 17 Dec 2003 11:08:25 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: PCI Express support for 2.4 kernel
In-Reply-To: <Pine.LNX.4.58.0312162240040.8541@home.osdl.org>
Message-ID: <Pine.GSO.4.58.0312171105200.24864@waterleaf.sonytel.be>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> 
 <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>  <3FDDACA9.1050600@intel.com>
 <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com>
 <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com>
 <Pine.LNX.4.58.0312160844110.1599@home.osdl.org> <3FDFF81F.7040309@intel.com>
 <Pine.LNX.4.58.0312162240040.8541@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, Linus Torvalds wrote:
> On Wed, 17 Dec 2003, Vladimir Kondratiev wrote:
> > Hopefully, they (or we, should I count myself?) are not completely brain
> > dead. Old method still works.
>
> Good. I just wanted to check from a timing perspective - it means that
> this won't be an issue for most people for a while (ie until we start
> seeing actual PCI-X-specific hardware and drivers rather than just the
> support chipsets - and I obviously have no idea how long that will take)

    [...]

For the record: PCI Express is _not_ PCI-X.

PCI Express is a completely new bus system with new physical connectors. From a
software point of view, it's (more or less) backwards-compatible with PCI,
while PCI-X is completely backwards compatible with PCI.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
