Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269406AbUJSVVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269406AbUJSVVC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269645AbUJSVRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:17:37 -0400
Received: from gprs214-24.eurotel.cz ([160.218.214.24]:4480 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269673AbUJSVQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:16:13 -0400
Date: Tue, 19 Oct 2004 23:15:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041019211557.GD1142@elf.ucw.cz>
References: <200410160551.40635.adaplas@hotpop.com> <416FFFFD.28877.2F2B6C9@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416FFFFD.28877.2F2B6C9@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In the case of something like a Mac you would want to keep the
> > display blank until the early user space code initializes the
> > display in graphics mode. Only if you get a fatal error before this
> > would you dump the info using the Open Firmware display. Same
> > strategy would apply to x86. 
> 
> True. On the Mac they use the speakers so the user knows that the machine 
> is booting. Almost immediately after hitting the power you will hear a 
> calming sound coming from the speaker, and it might be another 5 seconds 
> or so before the actual video comes up. 

Heh, I'm trying to do the some in i386 resume case... If you can call
square waves at 600Hz "calming sound" :-). Having video early would
certainly be more welcome.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
