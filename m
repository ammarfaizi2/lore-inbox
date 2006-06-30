Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWF3SMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWF3SMF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWF3SME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:12:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5058 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964810AbWF3SMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:12:02 -0400
Date: Fri, 30 Jun 2006 20:11:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
Message-ID: <20060630181131.GA1709@elf.ucw.cz>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606271316220.17704@scrub.home>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-06-27 15:12:53, Roman Zippel wrote:
> Hi,
> 
> On Sun, 25 Jun 2006, H. Peter Anvin wrote:
> 
> > The majority of the patches are independent in the sense that they
> > should apply independently, but Makefile/Kbuild files may have to be
> > adjusted to build a partially patched tree.
> 
> I could now repeat all the concerns I already mentioned, why it shouldn't 
> be merged as is (that doesn't mean it shouldn't be merged at all!), but 
> they have been pretty much ignored anyway...
> 
> What I'm more interested in is basically answering the question and where 
> I hope to provoke a bit broader discussion: "What's next?"
> 
> Until recently for most developers klibc was not much more than a cool 
> idea, but now we have the first incarnation and now we have to do a 
> reality check of how it solves our problems. To say it drastically the 
> current patch set as it is does not solve a single real problem yet, it 
> only moves them from the kernel to kinit, which may be the first step but 
> where to?
> 
> So what problems are we going to solve now and how? The amount of 
> discussion so far is not exactly encouraging. If nobody cares, then there 
> don't seem to be any real problems, so why should it be merged at all? Are 
> shiny new features more important than functionality?
> 
> So anyone who likes to see klibc merged, because it will solve some kind 
> of problem for him, please speak up now. Without this information it's 
> hard to judge whether we're going to solve the right problems.
> 
> Peter, it would really help if you describe your own plans, how you want 
> to go forward with it, otherwise it leaves a huge amount of uncertainty 
> and since this is a rather big change, I think it's a real good idea to 
> reduce this uncertainty, so we know what to expect and everyone can better 

I'd like to eventually move swsusp out of kernel, and klibc means I
may be able to do that without affecting users. Being in kinit is good
enough, because I can actually share single source between kinit
version and suspend.sf.net version.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
