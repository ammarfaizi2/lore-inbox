Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316602AbSEUUkz>; Tue, 21 May 2002 16:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316598AbSEUUkS>; Tue, 21 May 2002 16:40:18 -0400
Received: from [195.39.17.254] ([195.39.17.254]:3226 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316599AbSEUUjN>;
	Tue, 21 May 2002 16:39:13 -0400
Date: Thu, 16 May 2002 23:56:59 +0000
From: Pavel Machek <pavel@suse.cz>
To: Larry McVoy <lm@work.bitmover.com>, Rusty Russell <rusty@rustcorp.com.au>,
        Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020516235658.E116@toy.ucw.cz>
In-Reply-To: <20020518200540.N8794@work.bitmover.com> <E179HtC-0001cB-00@wagner.rustcorp.com.au> <20020518210218.P8794@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > But as we all know, it is harder to remove a feature from Linux, than
> > to get the camel book through the eye of a needle (or something).
> 
> It's possible that I'm too tired to have grasped this, but if I have,
> you're all wet.  In all cases, read needs to return the number of bytes
> successfully moved.  If you ask for N and 1/2 of the way through N you
> are going to get a fault, and you return SEGFAULT, now how can I ever
> find out that N/2 bytes actually made it out to me?  I want to know that.
> If you are arguing that return N/2 is wrong, you are incorrect. 

Imagine "I reallyu want to know how much memory memcpy() copied!". It is
as unreasonable as that.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

