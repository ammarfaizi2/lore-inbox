Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTERRxb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 13:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTERRxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 13:53:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5385 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262145AbTERRx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 13:53:29 -0400
Date: Sun, 18 May 2003 20:06:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nathan Neulinger <nneul@umr.edu>
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
Message-ID: <20030518180623.GA8035@atrey.karlin.mff.cuni.cz>
References: <8812.1052841957@warthog.warthog> <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com> <20030513172029.GB25295@delft.aura.cs.cmu.edu> <20030517123044.GG686@zaurus.ucw.cz> <1053267749.23613.14.camel@nneul-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053267749.23613.14.camel@nneul-laptop>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ? If he has same uid as you *and* you
> > have >=1 process running, what prevents
> > him from gdb attach <that process>,
> > and force it to do whatever he needs
> > by forcing syscall?
> > 				Pavel
> 
> That's a good point, and perhaps it should be an option to not allow
> ptrace or other potentially dangerous operations between processes in
> different pags. But leave that optional, as it might still be useful -
> for example, logging in and diagnosing a daemon running in a separate
> pag.
> 
> It's not clear if this would be best as a per-pag flag or a global one
> though. 

Well, at that point you are getting quite far away from unix....
And this decision is pretty fundamental.

> 
> -- Nathan
> 
> ------------------------------------------------------------
> Nathan Neulinger                       EMail:  nneul@umr.edu
> University of Missouri - Rolla         Phone: (573) 341-4841
> Computing Services                       Fax: (573) 341-4216

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
