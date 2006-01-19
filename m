Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161267AbWASTBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161267AbWASTBM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbWASTBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:01:12 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:36498 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161267AbWASTBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:01:11 -0500
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly
	different	approach
From: Lee Revell <rlrevell@joe-job.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <s5hk6cw9h07.wl%tiwai@suse.de>
References: <20060119174600.GT19398@stusta.de>
	 <1137694944.32195.1.camel@mindpipe> <20060119182859.GW19398@stusta.de>
	 <1137696885.32195.12.camel@mindpipe>  <s5hk6cw9h07.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 14:01:08 -0500
Message-Id: <1137697269.32195.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 20:04 +0100, Takashi Iwai wrote:
> At Thu, 19 Jan 2006 13:54:45 -0500,
> Lee Revell wrote:
> > 
> > On Thu, 2006-01-19 at 19:28 +0100, Adrian Bunk wrote:
> > > On Thu, Jan 19, 2006 at 01:22:23PM -0500, Lee Revell wrote:
> > > > On Thu, 2006-01-19 at 18:46 +0100, Adrian Bunk wrote:
> > > > > 3. no ALSA drivers for the same hardware
> > > > > 
> > > > > SOUND_SB 
> > > > 
> > > > ALSA certainly does support "100% Sound Blaster compatibles (SB16/32/64,
> > > > ESS, Jazz16)", it would be a joke if it didn't...
> > > 
> > > That's not the problem, I should have added an explanation:
> > > 
> > > SOUND_SB (due to SOUND_KAHLUA and SOUND_PAS)
> > > 
> > 
> > Hmm.  From sound/oss/kahlua.c:
> > 
> > /*
> >  *      Initialisation code for Cyrix/NatSemi VSA1 softaudio
> >  *
> >  *      (C) Copyright 2003 Red Hat Inc <alan@redhat.com>
> >  *
> > 
> > Why was a new OSS driver written and accepted at such a late date, when
> > OSS was already deprecated?
> 
> You'll find out that it must be pretty easy to write kahlua driver for
> ALSA, too, if you look at kahlua.c.  Just need a hardware to certify
> if this is really demanded...

Yes, it looks simple enough to write a driver without the hardware, as
long as someone volunteers to test it...

Lee

