Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbWJJKuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWJJKuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 06:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbWJJKuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 06:50:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62374 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751555AbWJJKuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 06:50:03 -0400
Date: Tue, 10 Oct 2006 12:49:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Riss <frederic.riss@gmail.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com
Subject: Re: 2.6.18 suspend regression on Intel Macs
Message-ID: <20061010104948.GE31598@elf.ucw.cz>
References: <1160417982.5142.45.camel@funkylaptop> <20061010103910.GD31598@elf.ucw.cz> <1160476889.3000.282.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160476889.3000.282.camel@laptopd505.fenrus.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=115005083610700&w=2
> > > http://bugme.osdl.org/show_bug.cgi?id=6670
> > > 
> > > The symptom is:
> > >     irq 9: nobody cared (try booting with the "irqpoll" option)
> > >     Disabling IRQ #9
> > > when the system comes out of sleep, making ACPI non-functional.
> > > 
> > > Two days after having released 2.6.17, Linus commited a fix for this
> > > issue in his tree (commit 5603509137940f4cbc577281cee62110d4097b1b):
> > 
> > If fix was in 2.6.18-gitX, yes, that probably counts as a regression
> 
> "fix" for some value of the word.
> The problem is that this is very much against the spec, and also quite
> likely breaks a bunch of machines...
> 
> If we do this we probably should at least key this of some DMI
> identification for the mac mini..

Do we have reports of machines breaking?

But okay, basing it on DMI works for me. (Do those crappy Apple
machines have a DMI?)
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
