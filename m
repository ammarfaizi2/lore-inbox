Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264754AbTCCMNI>; Mon, 3 Mar 2003 07:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTCCMNH>; Mon, 3 Mar 2003 07:13:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45317 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264754AbTCCMNB>; Mon, 3 Mar 2003 07:13:01 -0500
Date: Mon, 3 Mar 2003 13:23:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: bert hubert <ahu@ds9a.nl>, Nigel Cunningham <ncunningham@clear.net.nz>,
       Roger Luethi <rl@hellgate.ch>, Pavel Machek <pavel@ucw.cz>,
       Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Message-ID: <20030303122325.GA20929@atrey.karlin.mff.cuni.cz>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams> <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch> <1046657290.8668.33.camel@laptop-linux.cunninghams> <20030303113153.GA18563@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303113153.GA18563@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The only thing that came up at the time was a suggestion to replace BUG_ON
> > > with while (which I didn't try because I'd like to keep my data).
> > 
> > I'll see if I can find a solution.
> 
> A data point may be that at one point, swsusp did work just fine for me.
> This was around 2.5.53, 2.5.54:
> 
> http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&threadm=20021227142032.GA6945%40outpost.ds9a.nl&rnum=1&prev=/groups%3Fq%3Dswsusp%2Bbert%2Bhubert%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3DUTF-8%26selm%3D20021227142032.GA6945%2540outpost.ds9a.nl%26rnum%3D1
> 
> I now use gcc 3.2.2 for compiling though. I've tried suspending a few times
> with 2.5.63bk5 and I get the BUG every time, so it appears to be
> deterministic and not racey.

Well, it does not happen on my machines, but I've already seen it
happen on computer with two harddrives.

							Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
