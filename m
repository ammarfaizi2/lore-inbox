Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWBSUVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWBSUVP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 15:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWBSUVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 15:21:15 -0500
Received: from mail.linicks.net ([217.204.244.146]:4845 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751007AbWBSUVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 15:21:14 -0500
From: Nick Warne <nick@linicks.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: No sound from SB live!
Date: Sun, 19 Feb 2006 20:20:36 +0000
User-Agent: KMail/1.9.1
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Pavel Machek <pavel@suse.cz>,
       tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
References: <20060218231419.GA3219@elf.ucw.cz> <7c3341450602190318o1c60e9b5w@mail.gmail.com> <1140377394.2733.341.camel@mindpipe>
In-Reply-To: <1140377394.2733.341.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602192020.36343.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 February 2006 19:29, Lee Revell wrote:

> > And now the confusing bit.  If I run alsamixer but DO NOT DO ANYTHING,
> > exit, then issue 'alsactl store', then 'alsactl restore' works again
> > OK - until next reboot...
>
> Sounds like you have 2 different alsactls installed.  The ALSA default
> one saves the mixer state in /etc/asound.state but lots of distros hack
> it up to save the state somewhere under /var.
>
> Use "alsactl -f" to force a restore of mixer state even if the mixer
> controls have changed (distros should do this by default but don't).

Lee,

Everybody here keeps saying that to me - I _don't_ have two alsactl's, I 
_don't_ have 2 asound.states (or more/any other alsactl files).

My base is Slackware 10 - a pretty clean distro.

Tonight my MIC is not working again from a reboot, and I can't get it going 
like I did before (??)...

Every reboot 'alsactl restore' breaks on one control or another now.

You mean -F too?  I don't understand why I should have to use --force.

It's a mystery?

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
