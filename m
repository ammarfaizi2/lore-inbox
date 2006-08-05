Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161534AbWHEGqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161534AbWHEGqy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 02:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161578AbWHEGqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 02:46:54 -0400
Received: from smurf.noris.de ([192.109.102.42]:35497 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1161534AbWHEGqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 02:46:53 -0400
Date: Sat, 5 Aug 2006 08:46:26 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rate-limit the RTC 'missed interrupts' warning.
Message-ID: <20060805064626.GC5963@kiste.smurf.noris.de>
References: <E1G9EuX-0001AR-0f@smurf.noris.de> <20060804224913.d4fb3bef.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804224913.d4fb3bef.akpm@osdl.org>
User-Agent: Mutt/1.5.11
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton:
> > Cc: recipient list not shown: ;
> 
> I'm assuming there was supposed to be a mailing list there.
> 
No, just mutt and/or exim being stupid.
> 
> What is causing your machine to lose so many RTC interrupts?

*One* was probably initializing the Zaptel card(s).

I don't know; the stuff scrolled off the screen way too fast.
(Could that printk itself provoke the condition?)

Aug  4 22:29:22 smurf kernel: rtc: lost some interrupts at 1024Hz.
Aug  4 22:29:53 smurf last message repeated 1526 times
Aug  4 22:30:54 smurf last message repeated 3049 times
Aug  4 22:31:54 smurf last message repeated 3002 times

After patching and rebooting, I haven't seen the message again yet.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"Our bodies are always exposed to Satan. The maladies
 I suffer are not natural, but Devil's spells."
               [Martin Luther]
