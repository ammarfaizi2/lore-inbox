Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWGHUWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWGHUWh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWGHUWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:22:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49803 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030333AbWGHUWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:22:36 -0400
Date: Sat, 8 Jul 2006 22:22:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Sunil Kumar <devsku@gmail.com>,
       Bojan Smojver <bojan@rexursive.com>, Avuton Olrich <avuton@gmail.com>,
       Olivier Galibert <galibert@pobox.com>, Jan Rychter <jan@rychter.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-ID: <20060708202207.GA2546@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <ce9ef0d90607080942w685a6b60q7611278856c78ac0@mail.gmail.com> <1152377434.3120.69.camel@laptopd505.fenrus.org> <200607082125.12819.rjw@sisk.pl> <1152387552.3120.89.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152387552.3120.89.camel@laptopd505.fenrus.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  so that it's as
> > feature-rich as the other one.
> 
> this is one of the things that bothers me.
> "features features features"
> lets first get the basics right and working.
> Once we have that in tree for a release or two and it's really
> reliable... THEN and only THEN work on adding features.

It is okay... we are pretty careful, and most of those features are in
userspace code. As long as code does not damage the image in progress
(and I believe we have checksum there), more features should not
really hurt.

Besides, that is what this flamefest is about. Nigel wants all those
features in kernel, claims it can not be done incrementally, and due
to the design, he's probably right. uswsusp can do most/all of them in
userspace.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
