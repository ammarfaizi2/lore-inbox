Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVJaDOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVJaDOf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVJaDOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:14:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58499 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751299AbVJaDOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:14:34 -0500
Date: Sun, 30 Oct 2005 19:14:02 -0800
From: Paul Jackson <pj@sgi.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: ak@suse.de, tytso@mit.edu, torvalds@osdl.org, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-Id: <20051030191402.669273d5.pj@sgi.com>
In-Reply-To: <20051031001810.GQ7992@ftp.linux.org.uk>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<p73r7a4t0s7.fsf@verdi.suse.de>
	<20051030213221.GA28020@thunk.org>
	<200510310145.43663.ak@suse.de>
	<20051031001810.GQ7992@ftp.linux.org.uk>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al, responding to Andi,
> > because you never know whose bugs you're debugging
> > (and if the patch that is broken will even make it anywhere) 
> > 
> > In short mainline is frozen too long and -mm* is too unstable.
> 
> Besides, -mm is changing so fscking fast that it doesn't build on a lot
> of configs most of the time.

I think you are exagerating.

It builds on most configs most of the time in my experience.  If I
haven't tried a crosstool rebuild of the several defconfig arch's in a
week, I might expect one of the less popular archs to drop out, usually
for something so easy even I can figure some sort of fix or workaround.

It's tough to get stable kernels if the only kernels people want to
test on are stable kernels.  Linux is benefiting immensely from its
rapid evolution in various directions.

Granted - build and boot tested versions of *-mm, just a couple days
behind Andrew's patch set releases, would save people of dealing with
some of the simply stupid breakage.

Is there any corporate Linux supporter able to fund that?  Clearing
off the simple breakage could help attract the more serious and
diverse testing of a wider group of users with various specialized
interests.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
