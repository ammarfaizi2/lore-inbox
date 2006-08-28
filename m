Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWH1KB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWH1KB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 06:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWH1KB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 06:01:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15262 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964776AbWH1KBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 06:01:25 -0400
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
From: David Woodhouse <dwmw2@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: David Miller <davem@davemloft.net>, arnd@arndb.de,
       linux-arch@vger.kernel.org, jdike@addtoit.com, B.Steinbrink@gmx.de,
       arjan@infradead.org, chase.venters@clientec.com, akpm@osdl.org,
       rmk+lkml@arm.linux.org.uk, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608281053.11142.ak@suse.de>
References: <200608281003.02757.ak@suse.de> <200608281028.13652.ak@suse.de>
	 <1156754436.5340.20.camel@pmac.infradead.org>
	 <200608281053.11142.ak@suse.de>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 11:00:32 +0100
Message-Id: <1156759232.5340.36.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 10:53 +0200, Andi Kleen wrote:
> 
> > /usr/include/linux is _not_ a place to dump "reference code" in lieu of
> > documentation on using kernel interfaces.
> 
> At least for the system call interface it was always. It is not
> my fault you're trying to suddenly redefine it to be something else.

I'm trying to 'suddenly redefine' kernel headers as something that
_isn't_ just a library of random crap for people to abuse in userspace
as they see fit, then whine when something breaks even though it was
never really guaranteed to work when abused in that way anyway.

So far, you're just reminding me why that needed to be done.

> > Besides, the _syscallX implementations in the kernel were generally
> > unsuitable for use [as a reference implementation]
> 
> I disagree. I used them and they worked great for me.

Really? You used them as a reference implementation? Didn't you already
know how x86_64 syscalls work?

Or were you saying you just happened to use the x86_64 implementation of
_syscallX stuff in some userspace hacks, and it happened to work? In
which case go and line up behind the guy who said that about atomic.h on
i386 and only ever tested it on UP. The doctor will get to you later.

-- 
dwmw2

