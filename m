Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWACTbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWACTbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWACTbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:31:03 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:46241 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932498AbWACTbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:31:01 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1136312901.24703.59.camel@mindpipe>
References: <20050726150837.GT3160@stusta.de>
	 <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl>
	 <200601031629.21765.s0348365@sms.ed.ac.uk>
	 <20060103170316.GA12249@dspnet.fr.eu.org>
	 <1136312901.24703.59.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 20:30:40 +0100
Message-Id: <1136316640.4106.26.camel@unreal>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-08.tornado.cablecom.ch 32700; Body=2
	Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 13:28 -0500, Lee Revell wrote:

> Please provide a reproducible test case where an app *that we have the
> source code for* works with native OSS or the in kernel /dev/dsp OSS
> emulation and fails with the aoss/alsa-lib/userspace OSS emulation and
> it will be fixed ASAP.

I didn't know AOSS, but http://www.baycom.org/~tom/ham/soundmodem/ fails
with ALSA's kernel OSS emulation. Given that ALSA's kernel OSS emulation
is buggy since a couple of years and nobody feels like fixing it and you
seem to be telling that aoss is better anyway, are we going to remove
snd_pcm_oss as well?

Tom


