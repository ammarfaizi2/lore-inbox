Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWIRMEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWIRMEY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 08:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWIRMEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 08:04:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26025 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964992AbWIRMEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 08:04:23 -0400
Date: Mon, 18 Sep 2006 14:04:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Joshua Brindle <method@gentoo.org>
Cc: David Madore <david.madore@ens.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
Message-ID: <20060918120424.GA5370@elf.ucw.cz>
References: <20060910133759.GA12086@clipper.ens.fr> <20060910134257.GC12086@clipper.ens.fr> <1157905393.23085.5.camel@localhost.localdomain> <450451DB.5040104@gentoo.org> <20060917181422.GC2225@elf.ucw.cz> <450DB274.1010404@gentoo.org> <20060917211602.GA6215@clipper.ens.fr> <1158579966.8680.24.camel@twoface.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158579966.8680.24.camel@twoface.columbia.tresys.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The benefits of this are so minuscule and the cost is so high if you are 
> > > ever to use it that it simply won't happen..
> > 
> > I'm withdrawing that patch anyway, in favor of a LSM-style approach,
> > the "cuppabilities" module (cf. the patch I posted a couple of hours
> > ago with that word in the title, and I'll be posting a new version in
> > a day or so, or cf. <URL:
> > http://www.madore.org/~david/linux/cuppabilities/
> >  >).  In this case, the relative cost will be lower since the
> > security_ops->inode_permission() hook is called no matter what.
> > 
> 
> You misunderstand. I don't mean the performance cost is high, I mean the
> cost of an application to actually be able to run without open() (what I
> was saying before, static built, no glibc, no conf files, no name
> lookups, etc). I never see this being used in the real world because of
> the extreme limitations.

It is already being used. See config_seccomp.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
