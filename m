Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUHIL11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUHIL11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 07:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUHIL10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 07:27:26 -0400
Received: from gprs214-243.eurotel.cz ([160.218.214.243]:21376 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266485AbUHIL1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 07:27:05 -0400
Date: Mon, 9 Aug 2004 13:26:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sven-Haegar Koch <haegar@sdinet.de>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Suspend/Resume support for ati-agp
Message-ID: <20040809112649.GA9793@elf.ucw.cz>
References: <Pine.LNX.4.58.0408080331490.15568@mercury.sdinet.de> <20040808195021.GB7765@elf.ucw.cz> <Pine.LNX.4.58.0408091203310.12175@mercury.sdinet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408091203310.12175@mercury.sdinet.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > while trying to debug a strange resume problem with 2.6.8-rc3-mm1 and
> > > software suspend 2 I suspeced ati-agp, and created the following attached
> > > patch to add powermanagement support for it.
> > >
> > > I don't know if it's the completely right thing to do, I just copied the
> > > way via-agp and intel-agp do it - but perhaps you like it and want to send
> > > it upstream.
> >
> > Looks good to me.
> >
> > > ps:
> > > this did not fix the strange "weird vertical bars instead of movie in
> > > mplayer after resume" I have, but does not do any bad things either
> > > ;)
> >
> > Hmm, and does it fix anything?
> 
> Nothing I could find.
> 
> suspend to disk with swsusp in 2.6.8-rc3-mm1 does not work at all for me,
> I just get a oops longer than screen height after resume, which I can't
> capture because my thinkpad r40e does not have a serial port.
> sorry, but I didnt test with it after creating this patch.

Can you try "echo shutdown > /sys/power/disk"? Probably with
snd_ali5154 unloaded.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
