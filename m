Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWBKTr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWBKTr2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 14:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWBKTr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 14:47:28 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:11396 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964777AbWBKTr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 14:47:27 -0500
Subject: Re: [Alsa-devel] Re: ALSA - pnp OS bios option
From: Lee Revell <rlrevell@joe-job.com>
To: Nick <nick@linicks.net>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
In-Reply-To: <7c3341450602110556u75c4bfffq@mail.gmail.com>
References: <200601092022.56244.nick@linicks.net>
	 <200601101759.20707.nick@linicks.net> <s5hek3geyup.wl%tiwai@suse.de>
	 <200602111054.50947.nick@linicks.net>
	 <7c3341450602110556u75c4bfffq@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 11 Feb 2006 14:47:23 -0500
Message-Id: <1139687243.19342.95.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-11 at 13:56 +0000, Nick wrote:
> > Ummm.  At the command line, same errors also.  So I deleted /etc/asound.state
> > and reconfigured alsamixer from scratch.  Then following 'alsactl store',
> > 'alsactl restore' completes without issue (i.e. works clean).
> >
> > If I then reboot, the same damn control #47 errors happen again.  It's as if
> > something changes my asound.state file at boot time time?
> >
> > Ideas?  This is driving me potty.
> >
> 
> OK, talking to myself (testing, testing, 1-2-3) - I have resolved this
> issue after spending 2 hours trying to get my Mic to work again in
> Teamspeak (why is there _so_ many frigging mixers
> (alsamixer/amixer/aumix/kmix/arts) that all seem to do different
> things...

Because people keep writing half-assed mixers, rather than fixing the
existing ones, and distros inexplicably include 5 of them.  Half the
mixers out there only speak OSS, and distros ship them anyway.

Lee

