Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933163AbWF3Vyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933163AbWF3Vyb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 17:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933160AbWF3Vyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 17:54:31 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:27031 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S933223AbWF3Vya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 17:54:30 -0400
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Olivier Galibert <galibert@pobox.com>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       perex@suse.cz, Olaf Hering <olh@suse.de>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1151703286.11434.61.camel@laptopd505.fenrus.org>
References: <20060629192128.GE19712@stusta.de>
	 <44A54D8E.3000002@superbug.co.uk> <20060630163114.GA12874@dspnet.fr.eu.org>
	 <1151702966.32444.57.camel@mindpipe>
	 <1151703286.11434.61.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 17:54:37 -0400
Message-Id: <1151704479.32444.72.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 23:34 +0200, Arjan van de Ven wrote:
> On Fri, 2006-06-30 at 17:29 -0400, Lee Revell wrote:
> > As sound hardware gets dumber and cheaper, kernel OSS emulation will
> > become increasingly useless.  The cheap onboard devices (and even mid
> > range stuff like the SBLive! 24 bit) require sample rate conversion,
> > mixing, and even volume control to be handled in software.  ALSA's
> > in-kernel OSS emulation does not have these features and never will.
> > 
> > (I wish the authors of Skype, Flash, TeamSpeak, Enemy Territory, and
> > other proprietary OSS-only apps would understand this ;-)
> 
> 
> maybe it's time to start printing a warning to users of OSS api (rate
> limited etc etc)

It might help, but I'm not so sure.  The users have been complaining for
years (the most common complaint by far on #alsa is that OSS apps block
the soundcard) but these vendors don't seem to listen.  I doubt that
complaints in the kernel log will have an effect if they won't listen to
their users.

I've heard that one reason they won't port to ALSA is that they think
the in-kernel OSS emulation will be "fixed" someday.  Maybe we need to
make it clearer that this won't happen?

Lee

