Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVCEV6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVCEV6V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 16:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVCEV6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 16:58:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52386 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261205AbVCEV6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 16:58:17 -0500
Date: Sat, 5 Mar 2005 22:58:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: swsusp memory freeing [was Re: swsusp: allow resume from initramfs]
Message-ID: <20050305215806.GB14823@elf.ucw.cz>
References: <20050304101631.GA1824@elf.ucw.cz> <20050304030410.3bc5d4dc.akpm@osdl.org> <20050304175038.GE9796@ip68-4-98-123.oc.oc.cox.net> <1109971327.3772.280.camel@desktop.cunningham.myip.net.au> <20050304214329.GD2385@elf.ucw.cz> <1109973035.3772.291.camel@desktop.cunningham.myip.net.au> <20050304220709.GE2385@elf.ucw.cz> <1109975474.3772.305.camel@desktop.cunningham.myip.net.au> <20050304225556.GA2647@elf.ucw.cz> <1109984867.3772.322.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109984867.3772.322.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > By the way, did you see the effect of the memory eating patch? I didn't
> > > think about it until someone emailed me, but the improvement was 50x
> > > speed in the best case!
> > 
> > Well, more interesting was that you actually freed much more memory
> > with your patch. *You actually made memory freeing to work*. So yes, I
> > like that one.
> 
> You might be misreading me. When you set the image size limit setting in
> Suspend2, it's a soft limit. The image size wouldn't actually get down
> to 2 meg; Suspend would just aim for that and eat memory until it saw it
> wasn't getting anywhere.

Well, numbers looked like with same 2MB soft limit, "new" version
actually freed more memory. Perhaps that's not the case...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
