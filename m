Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVHBNJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVHBNJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 09:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVHBNJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 09:09:51 -0400
Received: from gw.alcove.fr ([81.80.245.157]:3257 "EHLO placid.alcove-fr")
	by vger.kernel.org with ESMTP id S261508AbVHBNJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 09:09:50 -0400
Subject: Re: powerbook power-off and 2.6.13-rc[3,4]
From: Stelian Pop <stelian@popies.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>,
       debian-powerpc@lists.debian.org
In-Reply-To: <20050802125445.GA32322@atrey.karlin.mff.cuni.cz>
References: <1122904460.6491.41.camel@localhost.localdomain>
	 <1122905228.6881.9.camel@localhost>
	 <1122907136.31350.45.camel@localhost.localdomain>
	 <20050802111754.GC1390@elf.ucw.cz> <42EF5B4E.6090101@sipsolutions.net>
	 <1122982951.4652.14.camel@localhost.localdomain>
	 <1122985793.4648.4.camel@localhost.localdomain>
	 <20050802125445.GA32322@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=utf-8
Date: Tue, 02 Aug 2005 15:09:16 +0200
Message-Id: <1122988156.6087.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 02 août 2005 à 14:54 +0200, Pavel Machek a écrit :
> Hi!
> 
> > > > Pavel Machek wrote:
> > > > 
> > > > >Can you try without USB?
> > > > >
> > > > Not really. The keyboard is USB, and there's no PS/2 connector. I guess 
> > > > I maybe could do it via a timer, unload the modules and then have it 
> > > > shut down afterwards...
> > > 
> > > I'll build a kernel without USB and drive the laptop over the net and
> > > see what happens.
> > 
> > Without CONFIG_USB the poweroff still hangs, and this time the panel
> > goes completly white with dark spots appearing all over it (kinda scary
> > btw). A 5 seconds press on the power button force it to power off.
> 
> Yep, looks like screen burning, right?

Exactly.

>  So it is different kind of hang
> => USB has some problem but there's another one, too?

Seems that this is the case, yes.

> > This is on a 2.6.13-rc4, and I'm attaching the .config in case it
> > matters.
> 
> Could you try inserting printks to see where it hangs? Aha, with
> display turned off that is not going to be funny.

Unfortunately I won't have time to debug this right now (I leave on
vacation tomorrow), so somebody else will have to do it (and no, it is
not going to be funny to do this without display, serial port, buzzer
etc)

Stelian.
-- 
Stelian Pop <stelian@popies.net>

