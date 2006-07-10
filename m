Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965320AbWGJXWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965320AbWGJXWq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965323AbWGJXWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:22:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48066 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965320AbWGJXWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:22:45 -0400
Date: Tue, 11 Jul 2006 01:22:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: suspend2-devel@lists.suspend2.net, Arjan van de Ven <arjan@infradead.org>,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>, grundig <grundig@teleline.es>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-ID: <20060710232212.GD444@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <1152523109.4874.11.camel@laptopd505.fenrus.org> <20060710100227.GA25310@atrey.karlin.mff.cuni.cz> <200607110749.48209.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607110749.48209.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > As I said... if that is the case then it'd be easy to first merge "the
> > > right basics", get that solid, and THEN add the features. So far I've
> > > not seen that happen.
> >
> > Well.. Nigel claims his code can not be split into reasonable chunks.
> >
> > I actually wanted to get a version without advanced features
> > (userspace splash, compression, encryption, plugins), but he claims it
> > is not possible. Rafael is trying to persuade him to split out at
> > least freezer out...
> 
> When did you ask for that? Perhaps I missed it.

It was long time ago...

> The modularity is part of the basis of the redesign, so I couldn't easily 
> remove that. Removing the compression and encryption support is trivial 
> though (one file each, plus Makefile & Kconfig entries - no other 
> modifications needed). Userspace splash - well, just don't compile and 
> install that userspace component - suspend2 will keep working quite happily 
> without any userspace app to do a nice display (it will still do printks, so 
> you won't be flying completely blind).

Lets see the patches, then.

> As for the freezer, Rafael doesn't need to persuade me at all. I just need to 
> find the time to do what he requested.

Ok.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
