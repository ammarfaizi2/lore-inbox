Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261877AbSJ2PUf>; Tue, 29 Oct 2002 10:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSJ2PUf>; Tue, 29 Oct 2002 10:20:35 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10452 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261877AbSJ2PUe>; Tue, 29 Oct 2002 10:20:34 -0500
Date: Tue, 29 Oct 2002 16:26:50 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: jt@hpl.hp.com
cc: James McKenzie <james@fishsoup.dhs.org>, <linux-kernel@vger.kernel.org>,
       <trivial@rustcorp.com.au>
Subject: Re: [2.5 patch] allow only one Toshiba Type-O IR Port driver in the
 kernel
In-Reply-To: <20021021173233.GA20616@bougret.hpl.hp.com>
Message-ID: <Pine.NEB.4.44.0210291619310.14144-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Jean Tourrilhes wrote:

> 	Adrian,

Hi Jean,

> 	Thanks very much for the report. I personally uses modules,
> and I would prefer the ability to compile both modules, so that people
> can try both without having to recompile their kernel.

notice that my patch doesn't disallow to build both drivers as modules.

> 	I think a much better patch (and simpler in the long term)
> would be to just rename 'toshoboe_init' to 'donauboe_init' (plus the
> few other offending function). This is a case where the name doesn't
> really matter.
> 	What do you think ?

That's an alternate solution that should also fix the compile problem.

But as stated above my patch doesn't affect the case when both drivers are
modular which is usually the desired setup when you want to switch between
the two drivers.

> 	Jean

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed








