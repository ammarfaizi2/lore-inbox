Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWAUC1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWAUC1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 21:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWAUC1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 21:27:14 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:27865 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750785AbWAUC1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 21:27:13 -0500
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different
	approach
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Peter Zubaj <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
In-Reply-To: <Pine.LNX.4.61.0601201524080.22940@yvahk01.tjqt.qr>
References: <20060119174600.GT19398@stusta.de>
	 <200601191947.20748.pzad@pobox.sk>
	 <Pine.LNX.4.61.0601201524080.22940@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 21:27:10 -0500
Message-Id: <1137810430.3241.97.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 15:25 +0100, Jan Engelhardt wrote:
> >Hi,
> >
> >On Thursday 19 January 2006 18:46, Adrian Bunk wrote:
> >> SOUND_EMU10K1
> >> - ALSA #1735 (OSS emulation 4-channel mode rear channels not working)
> >
> >If I understand alsa - oss emulation correctly, I think, this will be not 
> >fixed soon (my opinion - never). This is too much work for too little gain.
> 
> On that way, I'd like to inquiry something:
> I have a card that works with the snd-cs46xx module.
> With the OSS emulation (/dev/dsp), I can only output 2 channels, and the 
> other two must be sent to /dev/adsp. Is this intended? Would not it be 
> easier to make /dev/dsp allow receiving an ioctl setting 4 channels?
> 

Why can't you just use aoss?

Lee

