Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVAGNyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVAGNyv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 08:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVAGNyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 08:54:51 -0500
Received: from gprs214-191.eurotel.cz ([160.218.214.191]:9088 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261414AbVAGNyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 08:54:46 -0500
Date: Fri, 7 Jan 2005 14:54:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>, vojtech@suse.cz
Cc: Lion Vollnhals <webmaster@schiggl.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp: properly suspend and resume *all* devices
Message-ID: <20050107135418.GB1405@elf.ucw.cz>
References: <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net> <20050103084713.GB2099@elf.ucw.cz> <20050103101423.GA4441@ip68-4-98-123.oc.oc.cox.net> <20050103150505.GA4120@ip68-4-98-123.oc.oc.cox.net> <loom.20050104T093741-631@post.gmane.org> <20050104214315.GB1520@elf.ucw.cz> <41DC0E70.4000005@schiggl.de> <20050106222927.GC25913@elf.ucw.cz> <s5hoeg1wduz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hoeg1wduz.wl@alsa2.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I have a problem with net-devices, ne2000 in particular, in 2.6.9 and 
> > > 2.6.10, too. After a resume the ne2000-device doesn't work anymore. I 
> > > have to restart it using the initscripts.
> > > 
> > > How do I add suspend/resume support (to ISA devices, like my ne2000)?
> > > Can you point me to some information/tutorial?
> > 
> > Look how i8042 suspend/resume support is done and do it in similar
> > way...
> 
> Yep it's fairly easy to implement in that way (I did for ALSA).
> 
> But i8042 has also pm_register(), mentioning about APM.  Isn't it
> redundant?

Yes, it looks redundant. Vojtech, could you check why this is still
needed? It should not be.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
