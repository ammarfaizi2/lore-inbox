Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267986AbRHATjm>; Wed, 1 Aug 2001 15:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268008AbRHATjc>; Wed, 1 Aug 2001 15:39:32 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:17419 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S267986AbRHATj1>; Wed, 1 Aug 2001 15:39:27 -0400
From: bvermeul@devel.blackstar.nl
Date: Wed, 1 Aug 2001 21:42:19 +0200 (CEST)
To: Jussi Laako <jlaako@pp.htv.fi>
cc: Russell King <rmk@arm.linux.org.uk>, Per Jessen <per.jessen@enidan.com>,
        <linux-kernel@vger.kernel.org>, <linux-laptop@vger.kernel.org>
Subject: Re: PCMCIA control I82365 stops working with 2.4.4
In-Reply-To: <3B68557B.7816FE4B@pp.htv.fi>
Message-ID: <Pine.LNX.4.33.0108012139330.31291-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, Jussi Laako wrote:

> Russell King wrote:
> >
> > Use the yenta module instead of the i82365 module.
>
> Kills (deadlocks) my Toshiba Satellite when loaded as module (complains
> about missing interrupts). When built into kernel it just complains but
> doesn't lockup the machine.
>
> Older kernels/pcmcia-cs i82365 was working fine. (2.2.x and early 2.4.x)
>
> I should have stayed with RedHat 6.2, but I wanted journaling filesystem...
>
> Maybe I'm doing something wrong but dunno what.

Try going to your bios and setting the PCMCIA adapter to Cardbus/16bit
instead of Auto. The Toshiba Topic chipsets are buggy, change their PCI
identifiers with different bios settings, and are just a plain pain in the
ass to get working. Then use the yenta driver (preferrably in kernel), and
I think you will find it works now. :)

Bas Vermeulen, who has had some bad experiences with Toshiba laptops. And
it's impossible to get specs for em too.

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

