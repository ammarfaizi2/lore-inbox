Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbTFAQE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 12:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264661AbTFAQE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 12:04:59 -0400
Received: from miranda.zianet.com ([216.234.192.169]:25616 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264660AbTFAQE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 12:04:58 -0400
Subject: Re: Question about style when converting from K&R to ANSI C.
From: Steven Cole <elenstev@mesatop.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030601160228.GB3012@work.bitmover.com>
References: <1054446976.19557.23.camel@spc>
	 <20030601132626.GA3012@work.bitmover.com>
	 <20030601134942.GA10750@alpha.home.local>
	 <20030601140602.GA3641@work.bitmover.com> <1054479734.19552.51.camel@spc>
	 <20030601150951.GC3641@work.bitmover.com> <1054482640.19552.69.camel@spc>
	 <20030601160228.GB3012@work.bitmover.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054484287.19551.79.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Jun 2003 10:18:08 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-01 at 10:02, Larry McVoy wrote:
> > I have used more traditional style where the new Linus style was not
> > warranted.  Here is the patch for fs/jfs/jfs_xtree.c:
> > 
> > --- bk-current/fs/jfs/jfs_xtree.c	2003-05-31 20:30:47.000000000 -0600
> > +++ linux/fs/jfs/jfs_xtree.c	2003-05-31 21:02:14.000000000 -0600
> > @@ -4225,8 +4225,7 @@
> >   *      at the current entry at the current subtree root page
> >   *
> >   */
> > -int xtGather(t)
> > -btree_t *t;
> > +int xtGather(btree_t *t)
> >  {
> >  	int rc = 0;
> >  	xtpage_t *p;
> > 
> > I haven't yet sent that to the maintainer (worked until late last night
> > and still getting -ENOTENOUGHCOFFEE from brain).  
> > 
> > Anyway, I agree that more traditional styles should be used unless
> > otherwise indicated, but having the return type on the same line as the
> > function name is something I've warmed up to.  
> 
> OK, whatever.  But are you planning on trying to reformat the kernel and
> get that pushed into the mainline?  That's a fool's errand for lots of 
> reasons.  Nobody is going to get excited about having to look through 
> tons of patches which are all white space changes.  And it screws up
> the revision history.  Annotated listings and being able to go from that
> to the patch are a nice thing.  If you get all this stuff applied you 
> are hiding the real authorship of each of these function declarations.

Nope.  I'm just doing the absolute minimum.  Others have suggested using
Lindent and friends, but that would result in the undesirable
side-effects you've pointed out, and for little or no gain.  So, I for
one, will _not_ be doing that.

Obfuscating real authorship is a definite problem however.  But I'm
confident that you and your Bitkeeper elves can come up with a good
solution to this.  Surely this problem must slop over into other areas.

Steven

