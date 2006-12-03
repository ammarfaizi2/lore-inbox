Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758849AbWLCXP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758849AbWLCXP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 18:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758846AbWLCXP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 18:15:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6113 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1758834AbWLCXP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 18:15:27 -0500
Date: Mon, 4 Dec 2006 00:15:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Al Viro <viro@ftp.linux.org.uk>,
       Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061203231516.GG9876@elf.ucw.cz>
References: <200612022243.58348.zippel@linux-m68k.org> <20061202215941.GN3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022306360.1867@scrub.home> <20061202224018.GO3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022345520.1867@scrub.home> <20061203102108.GA1724@elf.ucw.cz> <20061203112706.GA12722@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612031602570.1867@scrub.home> <20061203210113.GF9876@elf.ucw.cz> <Pine.LNX.4.64.0612032348580.1867@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612032348580.1867@scrub.home>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-12-03 23:52:54, Roman Zippel wrote:
> Hi,
> 
> On Sun, 3 Dec 2006, Pavel Machek wrote:
> 
> > > What exactly is the pita here? Al only came up with some rather 
> > > theoretical problems with no practical relevance.
> > 
> > Lack of type-checking in timers is ugly.
> 
> It's a matter of perspective, a bit more type checking would be nice, but 
> breaking the API just for that is ugly as well. Unless there is a bad need 
> for it, I don't think it's worth it...

I do not think Al is breaking anything. He's adding that typechecking,
old interface can still stay for a while.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
