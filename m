Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269538AbUJLIyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269538AbUJLIyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269547AbUJLIyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:54:50 -0400
Received: from gprs213-46.eurotel.cz ([160.218.213.46]:9856 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269538AbUJLIyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:54:13 -0400
Date: Tue, 12 Oct 2004 10:53:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: ncunningham@linuxmail.org, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: Totally broken PCI PM calls
Message-ID: <20041012085349.GA2292@elf.ucw.cz>
References: <1097455528.25489.9.camel@gaston> <200410110936.37268.david-b@pacbell.net> <1097529469.4523.3.camel@desktop.cunninghams> <200410111437.17898.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410111437.17898.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The machines I've tested with relatively generic 2.6.9-rc kernels
> don't use BIOS support for S4 when I call swsusp.
> 
> Of course the ACPI spec muddies the water by talking about two
> different states called "S4":  "S4 Sleeping", which is what I was
> talking about as G1/S4; and "S4 Non-Volatile Sleep" that's more
> what I've seen with swusp:  more like a G2 or G3 poweroff.
> 
> I'm willing to believe that there are systems on which swsusp
> tells drivers a less confusing story ... but I don't seem to have
> tested with those!

If you are entering S4 or S5 at the end of swsusp basically should not
matter to anyone. What we tell the drivers is same in both cases.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
