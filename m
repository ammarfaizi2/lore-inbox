Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965301AbWGJWsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbWGJWsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965306AbWGJWst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:48:49 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:56268 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965301AbWGJWss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:48:48 -0400
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
From: Lee Revell <rlrevell@joe-job.com>
To: Adam =?iso-8859-2?Q?Tla=B3ka?= <atlka@pg.gda.pl>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20060710132810.551a4a8d.atlka@pg.gda.pl>
References: <20060707231716.GE26941@stusta.de>
	 <p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe>
	 <20060710132810.551a4a8d.atlka@pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-2
Date: Mon, 10 Jul 2006 18:48:37 -0400
Message-Id: <1152571717.19047.36.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 13:28 +0200, Adam Tla³ka wrote:
> >From my point of view ALSA has many advantages if you want to dig in
> the card driver buffers/period etc. settings but lacks ease of use and
> some of simple in theory functionality is a pain - device enumeration
> or switching output mode/device without restarting apps or rewritting
> them so they have special function for that purpose.
> 

Does any available sound driver interface allow switching output devices
with no help from the app and without having to restart playback?  OSS
does not, and every Windows app I've used has a configuration option to
set the sound device, and you must stop and start playback for it to
take effect.

> esd, arts, jackd, polypd and other prove that ALSA is not enough
> and its functionality is far from perfect.
> 

esd and artsd are no longer needed since ALSA began to enable software
mixing by default in release 1.0.9.  As for jackd and other apps that
provide additional functionality - no one ever claimed ALSA would handle
every audio related function imaginable.  It's just a low level HAL.

Lee

