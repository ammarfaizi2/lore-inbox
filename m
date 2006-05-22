Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWEVAW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWEVAW7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 20:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWEVAW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 20:22:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5764 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964965AbWEVAW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 20:22:58 -0400
Date: Mon, 22 May 2006 02:22:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Neil Brown <neilb@suse.de>
Cc: Al Boldi <a1426z@gawab.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
Message-ID: <20060522002215.GC25184@elf.ucw.cz>
References: <200605200733.08757.a1426z@gawab.com> <20060520102526.GH10077@stusta.de> <200605201419.55428.a1426z@gawab.com> <17519.1323.822630.868492@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17519.1323.822630.868492@cse.unsw.edu.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> > With a stable API, I can just implement whatever w/o caring whether it is 
> > included into the kernel.  Now that's freedom!
> > 
> 
> That's userspace. 
> 
> Improve what is in the kernel so that it presents to userspace
> whatever API you need, and write stuff in userspace to your hearts
> content.  I'm sure that there is no need for the entire 'X' server to
> be in the kernel, and I'm equally sure that there are advantages in
> the kernel providing more services for an X server than it currently
> does.  You need to find that balance.  It may be hard, but there are
> people here who will help.  You add bits of functionality - people
> will question them and require you to justify them. Some will make it,
> some won't.  Bit by bit you will arrive at a workable solution.
> 
> As a sort of example: were I to start writing an NFS server for Linux
> today, I wouldn't put it all in the kernel.  I would figure out the
> minimum services I needed from the kernel and add them one at a time,
> at each step modifying the userspace NFS server to use this
> functionality.  Some of it would be quite tricky - particularly
> achieving zero-copy reads and single-copy writes.  But I'm sure it is
> possible, and I'm sure there are people here who would help point me
> in the right direction.

I'm sure it is still possible to rewrite knfsd into userspace
:-). With splice & friends, maybe it is now easier to do 0-copy...

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
