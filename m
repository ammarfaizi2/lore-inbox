Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWBLH4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWBLH4s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 02:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWBLH4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 02:56:47 -0500
Received: from mail.linicks.net ([217.204.244.146]:42382 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932327AbWBLH4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 02:56:47 -0500
From: Nick Warne <nick@linicks.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: ALSA - pnp OS bios option
Date: Sun, 12 Feb 2006 07:56:38 +0000
User-Agent: KMail/1.9
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
References: <200601092022.56244.nick@linicks.net> <200602111054.50947.nick@linicks.net> <1139687047.19342.91.camel@mindpipe>
In-Reply-To: <1139687047.19342.91.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602120756.38975.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 February 2006 19:44, Lee Revell wrote:
> > If I then reboot, the same damn control #47 errors happen again.  It's
> > as if
> > something changes my asound.state file at boot time time?
>
> Probably you have two different alsactl's installed, one that's
> hardcoded to save the state in /etc/asound.state, and a distro version
> that wants to save it in /var/lib/whatever.  It sounds like one is being
> run at boot and a different one at shutdown.

First thing I thought of - Slackware is a 'clean, straight' distro though, and 
the only asound.state file I had was in /etc/ and only one alsactl in 
default /usr/sbin

On Saturday 11 February 2006 22:07, Lee Revell wrote:
> > do we need to keep the alsa tools and
> > stuff current too?
>
> Yes - kernel upgrades should depend on alsa-lib upgrades (many distros
> seem to get this wrong).  This should be fixed in the future, but it's
> been this way for some time.

Well, it appears to have fixed the issues I had.  Several reboots since and no 
problems now.

Looking back, originally I had a 2.4.x kernel - I have since upgraded to 2.6.x 
series, plus built a lot of new tools and such from source - all except alsa 
stuff, of course - so it does make sense and I kick myself for not thinking 
about this in the beginning.  One to remember.

Thanks,

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
