Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWJEVMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWJEVMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWJEVMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:12:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:14720 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751365AbWJEVMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:12:15 -0400
Subject: Re: [Alsa-user] Pb with simultaneous SATA and ALSA I/O
From: Lee Revell <rlrevell@joe-job.com>
To: Dominique Dumont <domi.dumont@free.fr>
Cc: alsa-user <alsa-user@lists.sourceforge.net>,
       Francesco Peeters <Francesco@FamPeeters.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <87r6xmscif.fsf@gandalf.hd.free.fr>
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	 <13158.212.123.217.246.1159186633.squirrel@www.fampeeters.com>
	 <87y7rusddc.fsf@gandalf.hd.free.fr> <1160081110.2481.104.camel@mindpipe>
	 <87r6xmscif.fsf@gandalf.hd.free.fr>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 17:12:41 -0400
Message-Id: <1160082761.2481.106.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 23:01 +0200, Dominique Dumont wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > This is going to be a problem with the SATA driver not ALSA.  I've heard
> > that some motherboards do evil stuff like implementing legacy drive
> > access modes using SMM which would cause dropouts without xruns
> > reported.
> 
> Why do I hear distortion with PCM on SPDIF output and no distortion at
> all on analog front output ? (both with the SB Live card)

No idea.  Maybe SPDIF playback is more sensitive to timing glitches.
But the problem must be in the SATA driver not the emu10k1 driver.

Lee

