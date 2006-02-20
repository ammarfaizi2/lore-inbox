Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWBTXzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWBTXzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 18:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWBTXzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 18:55:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52367 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964835AbWBTXzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 18:55:42 -0500
Date: Tue, 21 Feb 2006 00:55:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, ghrt <ghrt@dial.kappa.ro>,
       kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz,
       tiwai@suse.de
Subject: Re: No sound from SB live!
Message-ID: <20060220235504.GI21557@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz> <1140395634.2733.450.camel@mindpipe> <20060220003939.GH15608@elf.ucw.cz> <200602200133.26293.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602200133.26293.s0348365@sms.ed.ac.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 01:33:26, Alistair John Strachan wrote:
> On Monday 20 February 2006 00:39, Pavel Machek wrote:
> > On Ne 19-02-06 19:33:54, Lee Revell wrote:
> > > On Sun, 2006-02-19 at 22:44 +0100, Pavel Machek wrote:
> > > > Hi!
> > > >
> > > > > > I tried enabled everything I could in alsamixer, but still could
> > > > > > not get it to produce some sound :-(.
> > > > >
> > > > > Is 2.6.15.4 also broken?
> > > >
> > > > 2.6.15.4 does not have support for my SATA controller, so it would be
> > > > quite complex to test that... I may have something wrong with
> > > > userspace, but alsamixer all to max, then cat /bin/bash > /dev/dsp
> > > > should produce some sound, no?
> > >
> > > So this isn't necessarily a regression - it's possible this device never
> > > worked?
> > >
> > > Creative has been known in the past to release 2 devices with identical
> > > serial numbers and different AC97 codecs.  Stuff like this is why it's
> > > almot impossible to prevent all driver regressions unless you can test
> > > every supported card...
> >
> > It did work _long_ time ago, and in different machine. Definitely not
> > in 2.6.15... maybe in 2.6.5.
> 
> With ALSA? Any chance the card is physically damaged? Try using the OSS driver 
> if it's still around, then you'll have a solid case to take up with Takashi.

I tried OSS driver, no luck. Vojtech reports card from same batch
failed for him.... He still has one more working...
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
