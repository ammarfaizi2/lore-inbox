Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWHQJpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWHQJpq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWHQJpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:45:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36028 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964784AbWHQJpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:45:45 -0400
Date: Thu, 17 Aug 2006 11:45:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Trager <Lee@PicturesInMotion.net>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Jason Lunz <lunz@falooley.org>, Jens Axboe <axboe@suse.de>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Stefan Seyfried <seife@suse.de>
Subject: Re: Merging libata PATA support into the base kernel
Message-ID: <20060817094512.GD17899@elf.ucw.cz>
References: <1155144599.5729.226.camel@localhost.localdomain> <20060810122056.GP11829@suse.de> <20060810190222.GA12818@knob.reflex> <200608102140.36733.rjw@sisk.pl> <44E3E1E6.9090908@PicturesInMotion.net> <20060817091842.GC17899@elf.ucw.cz> <1155808348.15195.55.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155808348.15195.55.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Well it seems I am one of those users who is bit by the resume bug. I
> > > was wondering why no developer has replied to my
> > > bug(http://bugzilla.kernel.org/show_bug.cgi?id=6840) even though many
> > > users have. Id try to fix it myself but Ive never done kernel
> 
> Probably because its a repeat of a well known problem and nobody has
> volunteered to fix it even when its been explained to them
> 
> When we set the HPA on boot we must do the same on resume or the error
> you see occurs.

This should not be it... it also happens on suspend-to-disk according
to the report, and during swsusp we do normal boot so HPA should be
initialized...?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
