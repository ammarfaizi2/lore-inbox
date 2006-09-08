Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWIHKqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWIHKqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 06:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWIHKqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 06:46:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64933 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750784AbWIHKqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 06:46:09 -0400
Date: Fri, 8 Sep 2006 12:45:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bernd Eckenfels <be-mail2006@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060908104550.GA920@elf.ucw.cz>
References: <20060907173449.GA24013@clipper.ens.fr> <E1GLPhz-0001T9-00@calista.eckenfels.net> <20060907230028.GB30916@elf.ucw.cz> <20060908012201.GA14280@lina.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908012201.GA14280@lina.inka.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If attacker already has priviledge foo, he can just go use it. He does
> > not have to exec() poor program not expecting to get priviledge foo,
> > then abusing it.
> 
> It is not about attackers. It is about normal usage. If you spawn a program,
> it might behave wrong since it does not know that it is priveledged. For
> example a network daemon might start a child process which interacts with
> the user, and forgets to drop priveldges for it.

Ok, something like that is possible, at least it is not a security
problem.

> > Sanitized here means "all regular capabilities set, all others
> > cleared".
> 
> Yes, however I thought this was exactly what the patch is not doing?

Yep, it needs to be fixed ;-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
