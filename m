Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVADLMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVADLMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 06:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVADLKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 06:10:54 -0500
Received: from gprs214-29.eurotel.cz ([160.218.214.29]:13495 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261159AbVADLJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 06:09:53 -0500
Date: Tue, 4 Jan 2005 12:08:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swsusp hanging the second time
Message-ID: <20050104110839.GF18777@elf.ucw.cz>
References: <200501041154.19030.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501041154.19030.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> there's a second, more serious problem with this laptop. It hangs the
> in the second swsusp cycle on suspension.
> As before 2.6.10, i386/UP/no highmem.
> On the screen I get the two messages "radeonfb resumed!" and
> "setting latency" superimposed and it hangs forever. This is a regression
> the previous user commented: "It worked under 2.6.6"

Unless it was on the same hardware/config, I'd not call it regression.

Anyway two suspends in the row seem to work here on 2.6.10+my
patches. I suspect you have problems with some more obscure driver.

Can you try going with minimal driver config to see if it is
reproducible? If it is broken even with minimal drivers, I'll try
harder to reproduce it here (but I believe it will just go away).

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
