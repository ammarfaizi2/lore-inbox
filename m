Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbTBEXl7>; Wed, 5 Feb 2003 18:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbTBEXl7>; Wed, 5 Feb 2003 18:41:59 -0500
Received: from bitmover.com ([192.132.92.2]:56761 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S265174AbTBEXl4>;
	Wed, 5 Feb 2003 18:41:56 -0500
Date: Wed, 5 Feb 2003 15:51:26 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Matt Reppert <arashi@yomerashi.yi.org>,
       Andrew Morton <akpm@digeo.com>, andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205235126.GA21064@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	Matt Reppert <arashi@yomerashi.yi.org>,
	Andrew Morton <akpm@digeo.com>, andrea@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205114353.6591f4c8.akpm@digeo.com> <20030205141104.6ae9e439.arashi@yomerashi.yi.org> <20030205233115.GB14131@work.bitmover.com> <1044492355.15565.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044492355.15565.8.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 12:45:55AM +0000, Alan Cox wrote:
> On Wed, 2003-02-05 at 23:31, Larry McVoy wrote:
> > > (BTW, Larry, the bk binaries segfault on my (glibc 2.3.1) i686 system. Any
> > > chance we could see binaries linked against 2.3.x? There's NSS badness between
> > > 2.2 and 2.3 that causes even static binaries to segfault ... )
> > 
> > Yes, NSS in glibc is the world's worst garbage.  Glibc segfaults if there
> > is no /etc/nsswitch.conf.  Nice.
> 
> bugzilla is your friend

Excuse my ignorance but how is that going to help me?  I know the problem
and the work around so is there some magic voodoo chant in a bugzilla db
someplace which will make glibc not segfault without changing the system?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
