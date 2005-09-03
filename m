Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161176AbVICHX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161176AbVICHX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 03:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161180AbVICHX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 03:23:59 -0400
Received: from rev.193.226.233.176.euroweb.hu ([193.226.233.176]:9232 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1161176AbVICHX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 03:23:58 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
       torvalds@osdl.org
In-reply-to: <20050902234042.1a7dba6e.akpm@osdl.org> (message from Andrew
	Morton on Fri, 2 Sep 2005 23:40:42 -0700)
Subject: Re: FUSE merging?
References: <E1EBJc2-0006J0-00@dorka.pomaz.szeredi.hu>
	<20050902153440.309d41a5.akpm@osdl.org>
	<E1EBQco-0006qr-00@dorka.pomaz.szeredi.hu> <20050902234042.1a7dba6e.akpm@osdl.org>
Message-Id: <E1EBSN9-00070P-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 03 Sep 2005 09:23:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  > The main sticking point with FUSE remains the permission tricks around
> >  > fuse_allow_task().  AFAIK it remains the case that nobody has come up with
> >  > any better idea, so I'm inclined to merge the thing.
> > 
> >  Do you promise?
> 
> I troll.  What others think matters.  But at this stage, objections would
> need to be substantial, IMO.

Fair enough.

> We're rather deadlocked on the permission thing, but if we can't
> come up with anything better then I'm inclined to say what-the-hell.

There's no disadvantage IMO.  It adds nearly zero complexity.  If
someone doesn't like it, it can be configured out in userspace.  And
it leaves no legacy interfaces to support if later a better method is
found.

> >   I can do a resplit and submit to Linus, if that takes
> >  some load off you.
> 
> Nah, then I'd just have to check that everything is the same.

OK.

Thanks,
Miklos
