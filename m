Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWBTAd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWBTAd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWBTAd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:33:57 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:55751 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751138AbWBTAd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:33:56 -0500
Subject: Re: No sound from SB live!
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@suse.cz>
Cc: ghrt <ghrt@dial.kappa.ro>, kernel list <linux-kernel@vger.kernel.org>,
       perex@suse.cz, tiwai@suse.de
In-Reply-To: <20060219214408.GL15311@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz>
	 <200602190127.27862.ghrt@dial.kappa.ro> <20060218234805.GA3235@elf.ucw.cz>
	 <1140310710.2733.315.camel@mindpipe>  <20060219214408.GL15311@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 19:33:54 -0500
Message-Id: <1140395634.2733.450.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 22:44 +0100, Pavel Machek wrote:
> Hi!
> 
> > > I tried enabled everything I could in alsamixer, but still could not
> > > get it to produce some sound :-(. 
> > 
> > Is 2.6.15.4 also broken?
> 
> 2.6.15.4 does not have support for my SATA controller, so it would be
> quite complex to test that... I may have something wrong with
> userspace, but alsamixer all to max, then cat /bin/bash > /dev/dsp
> should produce some sound, no?

So this isn't necessarily a regression - it's possible this device never
worked?

Creative has been known in the past to release 2 devices with identical
serial numbers and different AC97 codecs.  Stuff like this is why it's
almot impossible to prevent all driver regressions unless you can test
every supported card...

Lee

