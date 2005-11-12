Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVKLGRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVKLGRV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 01:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVKLGRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 01:17:21 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:16032 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932188AbVKLGRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 01:17:20 -0500
Subject: Re: CM8738 audio hampering while playing video on G450 PCI graphic
	card
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Hurenkamp <mark.hurenkamp@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131764444.11279.15.camel@mindpipe>
References: <200511120241.54383.mark.hurenkamp@xs4all.nl>
	 <1131764444.11279.15.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 12 Nov 2005 01:14:37 -0500
Message-Id: <1131776077.13373.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 22:00 -0500, Lee Revell wrote:
> On Sat, 2005-11-12 at 02:41 +0100, Mark Hurenkamp wrote:
> > Now whenever there's a lot of activety (like scrolling down when I'm
> > browsing on a news site like slashdot, or playing video) on the G450 (both in 
> > accelerated mode, as well as in unaccelerated framebuffer mode), the audio 
> > (onboard CMedia) starts to hamper. This happens regardless wether I'm using
> > alsa, or oss. (using mplayer to play an mp3, but also with DivX movies
> > the same problem occurs).
> 
> Sounds like a "singing capacitor".  Check the LKML archives.

Never mind, Alan is probably right.  If disabling PCIRetry does not work
you can also try Option "NoAccel" (not a viable way to run, just to
confirm the problem).

WRT singing capacitors, it does seem to be an increasing problem:

http://news.com.com/PCs+plagued+by+bad
+capacitors/2100-1041_3-5942647.html?tag=nefd.lede

The difference is that singing capacitors will cause noise in the audio,
while PCI stalls of the type Alan described will cause
dropouts/stuttering.

Lee

