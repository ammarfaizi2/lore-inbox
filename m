Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291841AbSBHVO6>; Fri, 8 Feb 2002 16:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291843AbSBHVOJ>; Fri, 8 Feb 2002 16:14:09 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:23302 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S291826AbSBHVNG>;
	Fri, 8 Feb 2002 16:13:06 -0500
Date: Fri, 8 Feb 2002 17:11:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
Message-ID: <20020208161118.GA329@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0202062131290.4832-100000@age.cs.columbia.edu> <E16YmT5-0008LS-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16YmT5-0008LS-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Wrong. man ping. ping -f doesn't do what you apparently think it does.
> > 
> > strace ping, you'll see it doing a 
> > 	setsockopt(7, SOL_SOCKET, SO_SNDTIMEO, [1], 8) = 0
> > 
> > on its socket.
> 
> Read the ping manual page. Then when you understand what ping -f does 
> come back and have a useful conversation.

But I guess it *would* be usefull to have -F option saying "feed data
as fast as possible", right? And it would be nice if this option did
not eat 100% cpu when possible, right?

So what he is asking for is pretty usefull behaviour.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
