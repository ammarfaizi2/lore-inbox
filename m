Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933065AbWF3Vex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933065AbWF3Vex (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 17:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933148AbWF3Vex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 17:34:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57238 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933065AbWF3Vex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 17:34:53 -0400
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
From: Arjan van de Ven <arjan@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Olivier Galibert <galibert@pobox.com>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       perex@suse.cz, Olaf Hering <olh@suse.de>
In-Reply-To: <1151702966.32444.57.camel@mindpipe>
References: <20060629192128.GE19712@stusta.de>
	 <44A54D8E.3000002@superbug.co.uk> <20060630163114.GA12874@dspnet.fr.eu.org>
	 <1151702966.32444.57.camel@mindpipe>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 23:34:45 +0200
Message-Id: <1151703286.11434.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 17:29 -0400, Lee Revell wrote:
> On Fri, 2006-06-30 at 18:31 +0200, Olivier Galibert wrote:
> > On Fri, Jun 30, 2006 at 05:13:02PM +0100, James Courtier-Dutton wrote:
> > > Adrian Bunk wrote:
> > > >- ALSA #1735 (OSS emulation 4-channel mode rear channels not working)
> > > 
> > > As the MAINTAINER of EMU10K1, I am happy for EMU10K1 driver to be 
> > > removed from the kernel.
> > > 
> > > ALSA #1735 is now closed. All the apps the user was trying also support 
> > > ALSA natively now, so OSS is not needed.
> > 
> > Are you joking ?
> > 
> 
> Even if you reject this argument, the bug is in ALSA's in-kernel OSS
> emulation, not the emu10k1 driver.
> 
> As sound hardware gets dumber and cheaper, kernel OSS emulation will
> become increasingly useless.  The cheap onboard devices (and even mid
> range stuff like the SBLive! 24 bit) require sample rate conversion,
> mixing, and even volume control to be handled in software.  ALSA's
> in-kernel OSS emulation does not have these features and never will.
> 
> (I wish the authors of Skype, Flash, TeamSpeak, Enemy Territory, and
> other proprietary OSS-only apps would understand this ;-)


maybe it's time to start printing a warning to users of OSS api (rate
limited etc etc)


