Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313774AbSDHV7O>; Mon, 8 Apr 2002 17:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313772AbSDHV7N>; Mon, 8 Apr 2002 17:59:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43529 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313775AbSDHV7I>; Mon, 8 Apr 2002 17:59:08 -0400
Date: Mon, 8 Apr 2002 23:59:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: m.knoblauch@teraport.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp fixes] Re: Linux 2.4.19pre5-ac3
Message-ID: <20020408215908.GI31172@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3CB1B89D.13DDF456@TeraPort.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +
> > +You have two ways to use this code. The first one is if you've compiled in
> > +sysrq support then you may press Sysrq-D to request suspend. The other way
> > +is with a patched SysVinit (my patch is against 2.76 and available at my
> > +home page). You might call 'swsusp' or 'shutdown -z <time>'.
> > +
> > +Either way it saves the state of the machine into active swaps and then
> > +reboots. By the next booting the kernel's resuming function is either triggered
> > +by swapon -a (which is ought to be in the very early stage of booting) or you
> > +may explicitly specify the swap partition/file to resume from with ``resume=''
> > +kernel option. If signature is found it loads and restores saved state. If the
> 
>  Does it have to be an "active swap partition"? What about systems
> without active swap, but space enough for a partition?

There you just make it partition and then mkswap/swapon it. Or did I
misunderstand the question?
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
