Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751950AbWCIWrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbWCIWrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWCIWrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:47:00 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:26524 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751950AbWCIWq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:46:59 -0500
Subject: Re: [Alsa-user] arecord under 2.6.15.4-rt17 ->overruns...
From: Lee Revell <rlrevell@joe-job.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Sergei Steshenko <steshenko_sergei@list.ru>,
       alsa-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <Pine.LNX.4.60.0603092336150.14584@poirot.grange>
References: <Pine.LNX.4.60.0603022032040.4969@poirot.grange>
	 <1141331113.3042.5.camel@mindpipe>
	 <Pine.LNX.4.60.0603022132160.4969@poirot.grange>
	 <1141333305.3042.14.camel@mindpipe>
	 <Pine.LNX.4.60.0603022207160.3033@poirot.grange>
	 <1141334604.3042.17.camel@mindpipe>
	 <Pine.LNX.4.60.0603022226130.3033@poirot.grange>
	 <1141335418.3042.25.camel@mindpipe>
	 <Pine.LNX.4.60.0603030012070.3397@poirot.grange>
	 <1141342018.3042.40.camel@mindpipe>
	 <Pine.LNX.4.60.0603030707270.2959@poirot.grange>
	 <1141410043.3042.116.camel@mindpipe>
	 <Pine.LNX.4.60.0603041429340.3283@poirot.grange>
	 <20060304154357.74f74cac@localhost>
	 <Pine.LNX.4.60.0603041823560.3601@poirot.grange>
	 <1141495123.3042.181.camel@mindpipe>
	 <Pine.LNX.4.60.0603042046450.3135@poirot.grange>
	 <1141509605.14714.11.camel@mindpipe>
	 <Pine.LNX.4.60.0603051915020.3204@poirot.grange>
	 <Pine.LNX.4.60.0603071851190.3662@poirot.grange>
	 <1141757284.767.56.camel@mindpipe>
	 <Pine.LNX.4.60.0603071955350.3662@poirot.grange>
	 <1141758903.767.62.camel@mindpipe>
	 <Pine.LNX.4.60.0603092336150.14584@poirot.grange>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 17:46:56 -0500
Message-Id: <1141944417.13319.84.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 23:41 +0100, Guennadi Liakhovetski wrote:
> On Tue, 7 Mar 2006, Lee Revell wrote:
> 
> > Does the OSS driver have the same problem?
> 
> Surprise - I was not able to reproduce the problem with oss. Whereas with 
> alsa I was able to lock my PC again. What I do - just load respective 
> drivers and either "jackd -v -d alsa" or "jackd -v -d oss". And then just 
> put some load in the background + try to start ardour... With alsa I 
> wasn't even able to start it. With oss it did run, and no xruns reported 
> from jackd. Normal non-rt kernel. jackd started without --realtime.
> 
> Ouch
> 

OK, please file a report in the ALSA bug tracker against this driver.

Adrian, please add VIA to your list of OSS drivers that need to remain in the kernel.

Lee

