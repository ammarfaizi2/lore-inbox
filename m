Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752072AbWAEGnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbWAEGnF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbWAEGnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:43:05 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:56774 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752072AbWAEGnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:43:01 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Lee Revell <rlrevell@joe-job.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060103192449.GA26030@dspnet.fr.eu.org>
References: <20050726150837.GT3160@stusta.de>
	 <200601031629.21765.s0348365@sms.ed.ac.uk>
	 <20060103170316.GA12249@dspnet.fr.eu.org>
	 <200601031716.13409.s0348365@sms.ed.ac.uk>
	 <20060103192449.GA26030@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 01:42:57 -0500
Message-Id: <1136443378.24475.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 20:24 +0100, Olivier Galibert wrote:
> As for the OSS API being crippled, I'd take the 3 ioctl calls you need
> to setup a simple stereo 16bits output with OSS than the 13 ALSA
> library calls anyday.  Especially with the impressive lack of
> documentation you get about what the hell is a period, or what you can
> do except aborting when you get an error. 

Same thing as a fragment in OSS.  It's the number of frames between
interrupts from the audio interface.

Come on, Google could have told you that in 5 seconds.

Lee

