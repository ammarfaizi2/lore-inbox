Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752308AbWAFADw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbWAFADw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbWAFADv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:03:51 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24792 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752308AbWAFADb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:03:31 -0500
Subject: Re: [OT] ALSA userspace API complexity
From: Lee Revell <rlrevell@joe-job.com>
To: Hannu Savolainen <hannu@opensound.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0601060153440.27932@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de>
	 <20060103193736.GG3831@stusta.de>
	 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
	 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
	 <20060104030034.6b780485.zaitcev@redhat.com>
	 <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
	 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
	 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
	 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>
	 <s5hmziaird8.wl%tiwai@suse.de>
	 <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi>
	 <1136504364.847.88.camel@mindpipe>
	 <Pine.LNX.4.61.0601060153440.27932@zeus.compusonic.fi>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 19:03:28 -0500
Message-Id: <1136505809.6035.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 01:56 +0200, Hannu Savolainen wrote:
> On Thu, 5 Jan 2006, Lee Revell wrote:
> 
> > On Fri, 2006-01-06 at 01:06 +0200, Hannu Savolainen wrote:
> > > > - PCM with 3-bytes-packed 24bit formats
> > > Applications have no reasons to use for this kind of stupid format so
> > > OSS translates it to the usual 32 bit format on fly. In fact OSS API
> > > does have support for this format. 
> > 
> > What about hardware that only understands this format?
> There is no such hardware. Or is there?
> 

Yep, the Roland SC-D70 and EDIROL UA-5 in "advanced mode", I guess it
lets them cram more channels of 24 bit audio over a slow USB pipe.  It's
no fun...

Lee

