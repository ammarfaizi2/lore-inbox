Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265387AbSJaWCb>; Thu, 31 Oct 2002 17:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265388AbSJaWCa>; Thu, 31 Oct 2002 17:02:30 -0500
Received: from [195.39.17.254] ([195.39.17.254]:13316 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265387AbSJaWC2>;
	Thu, 31 Oct 2002 17:02:28 -0500
Date: Thu, 31 Oct 2002 23:53:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Dax Kelson <dax@gurulabs.com>, Chris Wedgwood <cw@f00f.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031225313.GC4331@elf.ucw.cz>
References: <1036046904.1521.74.camel@mentor> <Pine.GSO.4.21.0210310203570.13031-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210310203570.13031-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Without ACLs, if Sally, Joe and Bill need rw access to a file/dir, just
> > create another group with just those three people in.  Over time, of
> 
> If Sally, Joe and Bill need rw access to a directory, and Joe and Bill
> are using existing userland (any OS I'd seen), then Sally can easily
> fuck them into the next month and not in a good way.

Do you mean symlink attack?

> _That_ is the real problem.  Until that is solved (i.e. until all
> userland is written up to the standards allegedly followed in writing
> suid-root programs wrt hostile filesystem modifications) NO mechanism
> will help you.  ACLs, huge groups, whatever - setups with that sort
> of access allowed are NOT SUSTAINABLE with the current userland(s).

So userland needs to be improved. It already needs that modifications
because of /tmp. Is there any new issue there?
								Pavel
-- 
When do you have heart between your knees?
