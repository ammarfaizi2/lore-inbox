Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWAJR7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWAJR7j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWAJR7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:59:39 -0500
Received: from mail.linicks.net ([217.204.244.146]:36551 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751153AbWAJR7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:59:38 -0500
From: Nick Warne <nick@linicks.net>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] Re: ALSA - pnp OS bios option
Date: Tue, 10 Jan 2006 17:59:20 +0000
User-Agent: KMail/1.9
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
References: <200601092022.56244.nick@linicks.net> <1136883693.43c377ed83361@www.domainfactory-webmail.de> <s5hy81ofhl4.wl%tiwai@suse.de>
In-Reply-To: <s5hy81ofhl4.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101759.20707.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 11:27, Takashi Iwai wrote:

> > > Set_Control:894 Name mismatch ... Control #47
> > > 896: Index mismatch (0/0) for Control #47
> > > 1008: Bad control.47.value
> >
> > This usually happens when you use a different driver version that has
> > different mixer controls so that the saved state in /etc/asound.state
> > doesn't match.
>
> Use -F option for alsactl in your init script.

I see - specify the asound.state file to use.

So bios pnp OS ON/OFF both use different alsa drivers (or parts _of_ the 
driver) then - which in turn require different asound.state files?

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
