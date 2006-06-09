Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbWFIUjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbWFIUjQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWFIUjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:39:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:709 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965157AbWFIUjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:39:11 -0400
To: Jeff Garzik <jeff@garzik.org>
cc: Matthew Frost <artusemrys@sbcglobal.net>, Alex Tomas <alex@clusterfs.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3 
In-reply-to: Your message of Fri, 09 Jun 2006 15:45:16 EDT.
             <4489CFCC.40209@garzik.org> 
Date: Fri, 09 Jun 2006 13:38:03 -0700
Message-Id: <E1Fonk3-0004Ai-GK@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Jun 2006 15:45:16 EDT, Jeff Garzik wrote:
> Gerrit Huizenga wrote:
> > On Fri, 09 Jun 2006 14:51:55 EDT, Jeff Garzik wrote:
> >> PRECISELY.  So you should stop modifying a filesystem whose design is 
> >> admittedly _not_ modern!
> > 
> > So just how long do you think it would take to get a modern filesystem
> > into the hands of real users, supported by the distros?  From community
> > building, through design, development, testing, delivery?
> 
> Start from a known working point, and keep it working...

Then clone all the user level packages, work with distros to get
the new packages included, update the man pages, get those included,
make sure bug fixes for ext2 get propagated to ext4 - oh, and those
for ext3 as well.  And then work with mainline to decide when to
change from EXPERIMENTAL to stable, then decide how to get enough
users to make sure the testing is good enough, then work with the
distros to enable, then work with them to agree to provide support
to their most important, biggest, highest risk customers with this
new filesystem used by only 20 people because it isn't the default.

The repeat this whole discussion with each new feature proposed for
ext4 over the next 5 years, watch developers get disillusioned yet
again, watch 4 new competing filesystems pop up and try to be the
next great filesystem.  Watch them all fade away as the ultimately
battle for mindshare wears them out and the ever cascading war between
stability and support versus new features brings us back to where we
are again today.

Or just add the feature that the entire ext3 development community
thinks is stable enough to move forward, is well enough integrated
with the existing code to *not* be a bolt on, and is incrementally
small enough to be managed by its very own developer community
without the overhead of splitting that community even further.

The short words sound good but in reality we should all have lived
through this long enough to know better.

gerrit
