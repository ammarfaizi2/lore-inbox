Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbSKQDXR>; Sat, 16 Nov 2002 22:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267447AbSKQDXR>; Sat, 16 Nov 2002 22:23:17 -0500
Received: from bitmover.com ([192.132.92.2]:3007 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267449AbSKQDXP>;
	Sat, 16 Nov 2002 22:23:15 -0500
Date: Sat, 16 Nov 2002 19:30:08 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
Message-ID: <20021116193008.C25741@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1037490849.24843.11.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0211161915360.1337-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211161915360.1337-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 16, 2002 at 07:19:10PM -0800
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 07:19:10PM -0800, Linus Torvalds wrote:
> On 16 Nov 2002, Alan Cox wrote:
> > And in the real world you end up back with TCP. Been there, done that
> > with network debugger tools before.
> 
> .. and we have another "been there, done that" that says UDP works fine.
> 
> I also dislike overdesign with a passion. I'll believe we have to go to
> TCP when I see it - and even if that happens, I think we should do the UDP
> case first just to avoid having a monster ("start off simple, and evolve"  
> as opposed to "try to get it right the first time").

I've done this sort of "reliable UDP" on local networks before, it works 
just fine, no TCP is needed.  TCP is a really well designed protocol, it
handles an amazing range of problems gracefully.  It's overkill for a 
lan remote gdb.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
