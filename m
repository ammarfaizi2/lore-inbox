Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVB1PGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVB1PGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 10:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVB1PGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 10:06:25 -0500
Received: from gprs215-69.eurotel.cz ([160.218.215.69]:14786 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261631AbVB1PGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 10:06:24 -0500
Date: Mon, 28 Feb 2005 15:36:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       xorg@lists.freedesktop.org
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
Message-ID: <20050228143626.GB1429@elf.ucw.cz>
References: <21d7e997050220150030ea5a68@mail.gmail.com> <9e4733910502201542afb35f7@mail.gmail.com> <1108973275.5326.8.camel@gaston> <9e47339105022111082b2023c2@mail.gmail.com> <1109019855.5327.28.camel@gaston> <9e4733910502211717116a4df3@mail.gmail.com> <1109041968.5412.63.camel@gaston> <a728f9f9050221205634a3acf0@mail.gmail.com> <1109049217.5412.79.camel@gaston> <9e4733910502212203671eec73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910502212203671eec73@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I think that the driver is the "chief" here and the one to know what to
> > do with the cards it drives. It can detect a non-POSTed card and deal
> > with it.
> 
> What about the x86 case of VGA devices that run without a driver being
> loaded? Do we force people to load an fbdev driver to get the reset?
> The BIOS deficiency strategy works for these devices.

Yes, I think we do force people to load fbdev...

...because different BIOSes will be broken in slightly different ways,
and you'll probably need to know which BIOS you are trying to load...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
