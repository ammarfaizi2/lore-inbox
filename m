Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVAIVm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVAIVm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 16:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVAIVm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 16:42:28 -0500
Received: from gprs214-84.eurotel.cz ([160.218.214.84]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261830AbVAIVmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 16:42:25 -0500
Date: Sun, 9 Jan 2005 22:16:11 +0100
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Subject: Re: 2.6.10-mm1: oops during swsusp in ac97 support
Message-ID: <20050109211611.GA1325@elf.ucw.cz>
References: <20050103182842.GA1420@elf.ucw.cz> <s5h4qhxgnl9.wl@alsa2.suse.de> <20050104212702.GA1456@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104212702.GA1456@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I have via82xx soundcard, and since 2.6.10-mm1, I get an oops in
> > > snd_ac97_resume. Does 
> > 
> > What happened exactly? :)
> 
> During suspend, at one point devices are resumed. I get NULL pointer
> dereference during that phase.
> 
> I'll mail you a screenshot in a private mail. I just hope you'll be
> able to decipher it, it is pretty hard to read. (If not let me know, I
> think I can read most of it but no numbers).
> 
> 2.6.10-mm1 is broken, 2.6.10-currentbk is not.

2.6.10-mm2 is ok, so problem went away.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
