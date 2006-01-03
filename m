Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWACS2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWACS2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWACS2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:28:25 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:40346 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932450AbWACS2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:28:25 -0500
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
In-Reply-To: <20060103170316.GA12249@dspnet.fr.eu.org>
References: <20050726150837.GT3160@stusta.de>
	 <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl>
	 <200601031629.21765.s0348365@sms.ed.ac.uk>
	 <20060103170316.GA12249@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 13:28:20 -0500
Message-Id: <1136312901.24703.59.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 18:03 +0100, Olivier Galibert wrote:
> On Tue, Jan 03, 2006 at 04:29:21PM +0000, Alistair John Strachan wrote:
> > This has nothing to do with the kernel option CONFIG_SND_OSSEMUL which Jan 
> > referred to, and to which I was responding. "aoss" is also not compatible 
> > with every conceivable program.
> 
> Especially not with plugins.  Flashplayer anybody?

Yes it's a known issue that the aoss emulation is not perfect, it's not
a reason to ditch ALSA, it's a reason to fix it.

Please provide a reproducible test case where an app *that we have the
source code for* works with native OSS or the in kernel /dev/dsp OSS
emulation and fails with the aoss/alsa-lib/userspace OSS emulation and
it will be fixed ASAP.

Lee

