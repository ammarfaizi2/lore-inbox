Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbUB0Vhp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbUB0Vgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:36:36 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:23617 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S263136AbUB0VeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:34:11 -0500
X-BrightmailFiltered: true
Date: Fri, 27 Feb 2004 22:34:26 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.3] Mouse loosing sync (again)
Message-ID: <20040227213426.GA28041@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040227201441.GA19946@dreamland.darkstar.lan> <20040227210057.GA924@ucw.cz> <20040227210801.GA26589@dreamland.darkstar.lan> <20040227212346.GA981@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227212346.GA981@ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Fri, Feb 27, 2004 at 10:23:46PM +0100, Vojtech Pavlik ha scritto: 
> On Fri, Feb 27, 2004 at 10:08:01PM +0100, Kronos wrote:
> 
> > > > These happened while surfing web with little activity on eth0 and while disks
> > > > were almost idle (-u1 is set on both of them). Using vmstat I see that
> > > > I'm getting around 1300 interrupts per second while moving mouse (less
> > > > than 1100 while doing nothing), so I don't think that there's something 
> > > > spinning in ISR for too long.
> > > > 
> > > > Problem first appeared in 2.6.2, 2.6.1 is unaffected. I see that in
> > > > 2.6.3 there's a patch which is supposed to fix this, but it still
> > > > happens for me.
> > > > 
> > > > Any clue?
> > > 
> > > The bad parity messages definitely suggest a problem with the mouse
> > > cable - either too long or broken.
> > 
> > Hum, but why does it work with older kernels? If I boot with 2.6.1 it
> > works without problems.
> 
> 2.6.1 ignores bad parity in mouse data.

Oh, I see. Thanks for the clarification, I'll try and see if I can
reproduce with another mouse.

Luca
-- 
Home: http://kronoz.cjb.net
"L'ottimista pensa che questo sia il migliore dei mondi possibili. 
 Il pessimista sa che e` vero" -- J. Robert Oppenheimer
