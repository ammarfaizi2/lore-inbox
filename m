Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759469AbWLCVBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759469AbWLCVBW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 16:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760097AbWLCVBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 16:01:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23013 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1758509AbWLCVBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 16:01:20 -0500
Date: Sun, 3 Dec 2006 22:01:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Al Viro <viro@ftp.linux.org.uk>,
       Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061203210113.GF9876@elf.ucw.cz>
References: <1165084076.24604.56.camel@localhost.localdomain> <20061202184035.GL3078@ftp.linux.org.uk> <200612022243.58348.zippel@linux-m68k.org> <20061202215941.GN3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022306360.1867@scrub.home> <20061202224018.GO3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022345520.1867@scrub.home> <20061203102108.GA1724@elf.ucw.cz> <20061203112706.GA12722@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612031602570.1867@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612031602570.1867@scrub.home>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-12-03 16:21:25, Roman Zippel wrote:
> Hi,
> 
> On Sun, 3 Dec 2006, Russell King wrote:
> 
> > I agree with Al, Matthew and Pavel.  The current timer stuff is a pita
> > and needs fixing, and it seems Al has come up with a good way to do it
> > without adding additional crap into every single user of timers.
> 
> What exactly is the pita here? Al only came up with some rather 
> theoretical problems with no practical relevance.

Lack of type-checking in timers is ugly.

> > Al - I look forward to your changes.
> 
> I don't. The current API is maybe not perfect, but changing the API for no 
> practical benefit would be an even bigger pita. I'd rather keep it as is.

Al is trying to  add type-checking in pretty nice & straightforward
manner. Please let him do it.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
