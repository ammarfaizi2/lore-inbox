Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWCIW4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWCIW4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbWCIW4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:56:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1034 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750846AbWCIW4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:56:53 -0500
Date: Thu, 9 Mar 2006 23:56:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Sergei Steshenko <steshenko_sergei@list.ru>,
       alsa-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [Alsa-user] arecord under 2.6.15.4-rt17 ->overruns...
Message-ID: <20060309225652.GH21864@stusta.de>
References: <1141495123.3042.181.camel@mindpipe> <Pine.LNX.4.60.0603042046450.3135@poirot.grange> <1141509605.14714.11.camel@mindpipe> <Pine.LNX.4.60.0603051915020.3204@poirot.grange> <Pine.LNX.4.60.0603071851190.3662@poirot.grange> <1141757284.767.56.camel@mindpipe> <Pine.LNX.4.60.0603071955350.3662@poirot.grange> <1141758903.767.62.camel@mindpipe> <Pine.LNX.4.60.0603092336150.14584@poirot.grange> <1141944417.13319.84.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141944417.13319.84.camel@mindpipe>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 05:46:56PM -0500, Lee Revell wrote:
> On Thu, 2006-03-09 at 23:41 +0100, Guennadi Liakhovetski wrote:
> > On Tue, 7 Mar 2006, Lee Revell wrote:
> > 
> > > Does the OSS driver have the same problem?
> > 
> > Surprise - I was not able to reproduce the problem with oss. Whereas with 
> > alsa I was able to lock my PC again. What I do - just load respective 
> > drivers and either "jackd -v -d alsa" or "jackd -v -d oss". And then just 
> > put some load in the background + try to start ardour... With alsa I 
> > wasn't even able to start it. With oss it did run, and no xruns reported 
> > from jackd. Normal non-rt kernel. jackd started without --realtime.
> > 
> > Ouch
> > 
> 
> OK, please file a report in the ALSA bug tracker against this driver.
> 
> Adrian, please add VIA to your list of OSS drivers that need to remain in the kernel.

As soon as I get a bug number from the ALSA bug tracker I'll add 
SOUND_VIA82CXXX to my list of OSS drivers that should stay.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

