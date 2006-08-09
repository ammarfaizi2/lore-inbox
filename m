Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWHINhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWHINhe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWHINhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:37:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14792 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750774AbWHINhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:37:32 -0400
Date: Wed, 9 Aug 2006 15:37:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net,
       linux-pm@osdl.org, ncunningham@linuxmail.org
Subject: Re: swsusp and suspend2 like to overheat my laptop
Message-ID: <20060809133717.GC3932@elf.ucw.cz>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com> <20060808235352.GA4751@elf.ucw.cz> <Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com> <20060809073958.GK4886@elf.ucw.cz> <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com> <20060809115843.GB3747@elf.ucw.cz> <Pine.LNX.4.58.0608090932460.3785@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608090932460.3785@gandalf.stny.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-08-09 09:35:31, Steven Rostedt wrote:
> 
> On Wed, 9 Aug 2006, Pavel Machek wrote:
> 
> >
> > > > How s2ram works would be useful info.
> > >
> > > No idea.
> >
> > Well, try it :-). suspend.sf.net.
> >
> 
> Debian testing has it installed already, so I tried that one.
> 
> # s2ram
> Machine is unknown.
> This machine can be identified by:
>     sys_vendor   = "IBM"
>     sys_product  = "288679U"
>     sys_version  = "ThinkPad G41"
>     bios_version = "1XET44WW (1.03 )"
> See http://en.opensuse.org/S2ram for details.
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> If you report a problem, please include the complete output above.
> 
> 
> 
> So then I tried s2ram -f
> 
> Well it went to sleep fine.  But when I tried to wake it up again, the
> screen didn't come back. I'm not sure if the keyboard was working either.
> But I could eject the CD and when I put it back in, it seemed to mount it.
> 
> Oh well, I'll have to debug that another day ;)

There's a very nice writeup... at underlined address.

you probably want -f -a 3 .
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
