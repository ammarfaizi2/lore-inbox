Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbVLUWvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVLUWvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVLUWvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:51:17 -0500
Received: from cerqueira.net ([195.23.98.191]:57578 "HELO home.cerqueira.org")
	by vger.kernel.org with SMTP id S964909AbVLUWvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:51:15 -0500
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
From: R C <v4l@cerqueira.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Adrian Bunk <bunk@stusta.de>, Sergey Vlasov <vsu@altlinux.ru>,
       mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
In-Reply-To: <s5hwthyxoz1.wl%tiwai@suse.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051220131810.GB6789@stusta.de>
	 <20051220155216.GA19797@master.mivlgu.local>
	 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>
	 <20051220191412.GA4578@stusta.de>
	 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>
	 <43A86B20.1090104@superbug.co.uk>
	 <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org>
	 <s5hpsnqzf86.wl%tiwai@suse.de>
	 <Pine.LNX.4.64.0512211026190.4827@g5.osdl.org>
	 <s5hwthyxoz1.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 22:50:43 +0000
Message-Id: <1135205444.3029.2.camel@frolic>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.2 (2.5.2-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all;

On Wed, 2005-12-21 at 19:52 +0100, Takashi Iwai wrote:
> > 
> > Well, you dropped the easiest: make saa7134 just use "late_initcall()".
> > 
> > It's not "correct", but it's certainly no less correct than just forcing a 
> > driver to be moved for link order reasons.
> 
> Yep, that's obviously the easiest one.  I'd vote for this, at least
> for 2.6.15, once after it's confirmed to work.
> 

I've just confirmed it works with rc6-git2. The driver activates
properly and works as expected.
I've just commited the changes to v4l, Mauro should send them upstream
later.

--
RC

