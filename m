Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268701AbTGLWi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 18:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbTGLWi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 18:38:27 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:58846 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S268701AbTGLWi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 18:38:26 -0400
Date: Sun, 13 Jul 2003 00:51:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linus Torvalds <torvalds@transmeta.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030712225143.GA1508@elf.ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307121734.29941.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > - user can abort at any time during suspend (oh, I forgot, I wanted
> > > to...) by just pressing Escape
> >
> > That seems like missfeature. We don't want joe random user that is at
> > the console to prevent suspend by just pressing Escape. Maybe magic
> > key to do that would be acceptable...
> 
> In case when suspending (and interrupting suspend) matters most - 
> laptops - Joe random user is the only user present. I myself would
> rather have an option to press ESC than remember what SysRq really 
> maps to as by the time I would figure that out the laptop would already
> be suspended.
> 
> IMHO, an option to use ESC, probably compile time option, is a good 
> thing.

No more compile time options, thanks.

And no escape. Doing something from keyboard is *ugly*. Magic sysrq is
ugly, too, but its usefull enough to outweight that.

Hmm, I noticed that I'm making same mistake with shift during
powerdown. I guess I should kill that hack.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
