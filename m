Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVBVGd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVBVGd1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 01:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVBVGd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 01:33:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:2263 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262211AbVBVGdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 01:33:24 -0500
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       xorg@lists.freedesktop.org
In-Reply-To: <9e4733910502212203671eec73@mail.gmail.com>
References: <Pine.LNX.4.58.0502201049480.18753@skynet>
	 <21d7e997050220150030ea5a68@mail.gmail.com>
	 <9e4733910502201542afb35f7@mail.gmail.com> <1108973275.5326.8.camel@gaston>
	 <9e47339105022111082b2023c2@mail.gmail.com>
	 <1109019855.5327.28.camel@gaston>
	 <9e4733910502211717116a4df3@mail.gmail.com>
	 <1109041968.5412.63.camel@gaston>
	 <a728f9f9050221205634a3acf0@mail.gmail.com>
	 <1109049217.5412.79.camel@gaston>
	 <9e4733910502212203671eec73@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 17:32:40 +1100
Message-Id: <1109053960.5326.91.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 01:03 -0500, Jon Smirl wrote:
> On Tue, 22 Feb 2005 16:13:36 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Mon, 2005-02-21 at 23:56 -0500, Alex Deucher wrote:
> > I think that the driver is the "chief" here and the one to know what to
> > do with the cards it drives. It can detect a non-POSTed card and deal
> > with it.
> 
> What about the x86 case of VGA devices that run without a driver being
> loaded? Do we force people to load an fbdev driver to get the reset?
> The BIOS deficiency strategy works for these devices.

Do we need to deal with those at all ? (I mean _really_: do we care ?)

And even if we did, then we could have the vga "legacy" driver use the
firmware loader to "boot" them. And again, you seem to dismiss all my
other arguments... 


Ben.


