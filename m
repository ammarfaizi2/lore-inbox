Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261539AbSJMPaV>; Sun, 13 Oct 2002 11:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261540AbSJMPaV>; Sun, 13 Oct 2002 11:30:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45841 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261539AbSJMPaU>; Sun, 13 Oct 2002 11:30:20 -0400
Date: Sun, 13 Oct 2002 16:36:08 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Art Haas <ahaas@neosoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C99 designated initializers for drivers/pcmcia
Message-ID: <20021013163608.B23142@flint.arm.linux.org.uk>
References: <20021012174721.GP633@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021012174721.GP633@debian>; from ahaas@neosoft.com on Sat, Oct 12, 2002 at 12:47:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 12:47:21PM -0500, Art Haas wrote:
> My mail to PCMCIA maintainer David Hinds bounces if sent to the
> address in the Maintainers file, and the address fished out of
> some of the code bounced too, so I'm sending this patch set to
> the list in hopes he (or the right maintainer) receives it.
> The patches convert drivers/pcmcia to use C99 named initializers,
> and all the patches are against 2.5.42. There are 25 patches in
> total, and the "cat"ing them together they're more that 20K, so
> I'm sending the patches as a compressed attachment. The patches
> were CC'd to Linus in the first mail that bounced.

I'll claim the following sa1100 stuff.  Merged into my bk tree.
If the other pcmcia stuff isn't in 2.5.43 and I'm not busy, I'll
pick up the rest.

> sa1100_adsbitsy.c
> sa1100_assabet.c
> sa1100_badge4.c
> sa1100_cerf.c
> sa1100_flexanet.c
> sa1100_freebird.c
> sa1100_generic.c
> sa1100_graphicsclient.c
> sa1100_graphicsmaster.c
> sa1100_h3600.c
> sa1100_jornada720.c
> sa1100_neponset.c
> sa1100_pangolin.c
> sa1100_pfs168.c
> sa1100_shannon.c
> sa1100_simpad.c
> sa1100_stork.c
> sa1100_system3.c
> sa1100_trizeps.c
> sa1100_xp860.c
> sa1100_yopy.c

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

