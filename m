Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266353AbUHIIpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266353AbUHIIpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266358AbUHIIpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:45:13 -0400
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:11648 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266353AbUHIIo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:44:28 -0400
Date: Mon, 9 Aug 2004 10:44:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: crow@old-fsckful.ath.cx, mochel@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.8-rc2-mm2] swsusp results on a hp compaq nx7000
Message-ID: <20040809084410.GB737@elf.ucw.cz>
References: <20040804120303.GA1828@final-judgement.ath.cx> <20040806201107.GD30518@elf.ucw.cz> <20040808092853.GC26305@old-fsckful.ath.cx> <20040808182440.GB620@elf.ucw.cz> <1092039852.28673.5.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092039852.28673.5.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > * locking with regard to preemption seems so be broken
> > 
> > I see it here, too.
> > 
> > > > > * ohci1394 seems to generate sporadic OOPs on resume (could be
> > > > >   preemption related)
> > 
> > I do not have firewire device to test with... There seem to be very
> > little of those beasts around, so I propose to ignore firewire for
> > now.
> 
> I have firewire hardware but no actual devices to plug in. Is that any
> help at all when it comes to testing? (I'm not building any support in
> or as modules at the moment).

It seems to be broken even in that situation, but as firewire hardware
is pretty uncommon... I guess we have bigger problems to solve.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
