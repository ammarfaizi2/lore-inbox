Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030872AbWKULaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030872AbWKULaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966964AbWKULaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:30:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39076 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S966961AbWKULaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:30:16 -0500
Date: Tue, 21 Nov 2006 12:30:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Komal Shah <komal.shah802003@gmail.com>
Cc: Vladimir <vovan888@gmail.com>, Tony Lindgren <tony@atomide.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Siemens sx1: merge framebuffer support
Message-ID: <20061121113005.GA1900@elf.ucw.cz>
References: <20061118181607.GA15275@elf.ucw.cz> <20061120190404.GD4597@atomide.com> <ce55079f0611202306l3cd57e48t68fe28e7e076d39a@mail.gmail.com> <3a5b1be00611210042p2237a0fbpece68912e3d23f4c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5b1be00611210042p2237a0fbpece68912e3d23f4c@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi1

> >> > Framebuffer support for Siemens SX1; this is second big patch. (Third
> >> > one will be mixer/sound support). Support is simple / pretty minimal,
> >> > but seems to work okay (and is somehow important for a cell phone :-).
> >>
> >> Pushed to linux-omap. I guess you're planning to send the missing
> >> Kconfig + Makefile patch for this?
> >>
> >> Also, it would be better to use omap_mcbsp_xmit_word() or
> >> omap_mcsbsp_spi_master_xmit_word_poll() instead of OMAP_MCBSP_WRITE as
> >> it does not do any checking that it worked. The aic23 and tsc2101
> >> audio in linux-omap tree in general has the same problem.
> >>
> >> Regards,
> >>
> >> Tony
> >>
> >
> >Hmm. McBSP3 in SX1 is used in "GPIO mode". The only line used is CLKX,
> >so I think OMAP_MCBSP_WRITE would be enough. Am I wrong ?
> 
> Please also send defconfig (may be siemens_sx1_defconfig OR
> omap_sx1_310_defconfig) patch for this mobile once, your minimum
> required patches are pushed to -omap git tree. Thanx.

Yes, will do. I was trying to get it compiling first.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
