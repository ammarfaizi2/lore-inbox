Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWFSCcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWFSCcD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 22:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWFSCcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 22:32:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39845 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750933AbWFSCcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 22:32:01 -0400
Date: Mon, 19 Jun 2006 03:39:00 +0200
From: Petr Baudis <pasky@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17
Message-ID: <20060619013900.GD24203@pasky.or.cz>
References: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org> <Pine.LNX.4.64.0606171902040.5498@g5.osdl.org> <4494C8E7.3080700@ens-lyon.org> <Pine.LNX.4.64.0606172036360.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606172036360.5498@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Jun 18, 2006 at 05:47:27AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> On Sat, 17 Jun 2006, Brice Goglin wrote:
> >
> > I guess I could use git to generate the full changelog once a new
> > release and keep it for later...
> 
> Well, if you are already a git user (or willing to become one), there's no 
> point in even keeping it for later.
> 
> 	[torvalds@g5 linux]$ time git log v2.6.16..v2.6.17 > /dev/null 
> 	
> 	real    0m0.484s
> 	user    0m0.448s
> 	sys     0m0.036s
> 
> ie the logfile generation really is almost free. And yes, that's the 
> _full_ big log (all 92 _thousand_ lines of it, from the 6113 commits in 
> the 2.6.16->17 case) being generated in under half a second.

I assume that this is with hot cache, which is something you shouldn't
assume for a use like this - you likely aren't in the middle of doing
stuff with the repository but just want to peek at the changes list.

Anyway, the nice thing about the Changelog files MIGHT be Google - it's
nice when googling around about your kernel problem ends up yielding
a changelog entry indicating that it's already fixed in a newer kernel
version. That is, if only Google crawled the changelogs. Does it stay
away of them because they have no extension?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
