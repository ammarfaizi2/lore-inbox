Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWBMTCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWBMTCh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWBMTCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:02:37 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:64447 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964782AbWBMTCg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:02:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZpDdYjSCrDsn8lXV6Xu2e0AQEU/qrAfwbnFBDma2/igWB79H43nMs1hhbGP0EASitPAdySu5KpY0VFJinen7OeYpT/hB7TaSz6Cfq0JE5wLt/pILPow2QNvLJmwQpUhrUQXsyD9TSNUyrzoD1QiOgExyeFjkatZq+65BdR6YD58=
Message-ID: <7c3341450602131102j712a0a17y@mail.gmail.com>
Date: Mon, 13 Feb 2006 19:02:34 +0000
From: Nick Warne <nick@linicks.net>
Reply-To: Nick Warne <nick@linicks.net>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Fw: PROBLEM: SB Live! 5.1 (emu10k1, rev. 0a) doesn't work with 2.6.15
Cc: Andrew Morton <akpm@osdl.org>, Jaroslav Kysela <perex@suse.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <s5hmzgv2ikl.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060213040900.1e360292.akpm@osdl.org>
	 <s5h7j7z47q4.wl%tiwai@suse.de>
	 <7c3341450602131054k71e3a8c4o@mail.gmail.com>
	 <s5hmzgv2ikl.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > As stated the solution for me was to update alsa-utils and alsa-libs
> > which fixed the issues I was getting - I found that if one of the
> > 'controls' (15, I think?) was invalid at boot, all the volume settings
> > in alsamixer got set to '0' (i.e. mute/turned off) - no sound.
>
> Such a problem is usually because of init script rather alsa-lib
> version.  It should call alsactl with -F option.

I would agree - but I only have one asound.state file, and also doing
the upgrade to said alsa utils and libs *fixed* it...

On my system at least something was going awry.

Nick
