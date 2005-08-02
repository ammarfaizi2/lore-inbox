Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVHBMyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVHBMyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVHBMyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:54:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19369 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261500AbVHBMyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:54:52 -0400
Date: Tue, 2 Aug 2005 14:54:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stelian Pop <stelian@popies.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>,
       debian-powerpc@lists.debian.org
Subject: Re: powerbook power-off and 2.6.13-rc[3,4]
Message-ID: <20050802125445.GA32322@atrey.karlin.mff.cuni.cz>
References: <1122904460.6491.41.camel@localhost.localdomain> <1122905228.6881.9.camel@localhost> <1122907136.31350.45.camel@localhost.localdomain> <20050802111754.GC1390@elf.ucw.cz> <42EF5B4E.6090101@sipsolutions.net> <1122982951.4652.14.camel@localhost.localdomain> <1122985793.4648.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122985793.4648.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Pavel Machek wrote:
> > > 
> > > >Can you try without USB?
> > > >
> > > Not really. The keyboard is USB, and there's no PS/2 connector. I guess 
> > > I maybe could do it via a timer, unload the modules and then have it 
> > > shut down afterwards...
> > 
> > I'll build a kernel without USB and drive the laptop over the net and
> > see what happens.
> 
> Without CONFIG_USB the poweroff still hangs, and this time the panel
> goes completly white with dark spots appearing all over it (kinda scary
> btw). A 5 seconds press on the power button force it to power off.

Yep, looks like screen burning, right? So it is different kind of hang
=> USB has some problem but there's another one, too?

> This is on a 2.6.13-rc4, and I'm attaching the .config in case it
> matters.

Could you try inserting printks to see where it hangs? Aha, with
display turned off that is not going to be funny.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
