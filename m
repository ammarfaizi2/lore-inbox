Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSJaQbv>; Thu, 31 Oct 2002 11:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbSJaQar>; Thu, 31 Oct 2002 11:30:47 -0500
Received: from waste.org ([209.173.204.2]:40879 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S263215AbSJaQam>;
	Thu, 31 Oct 2002 11:30:42 -0500
Date: Thu, 31 Oct 2002 10:36:50 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031163650.GC25906@waste.org>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.GSO.4.21.0210302135150.13031-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210302135150.13031-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 09:43:29PM -0500, Alexander Viro wrote:
> 
> 
> On Wed, 30 Oct 2002, Linus Torvalds wrote:
> 
> > > ext2/ext3 ACLs and Extended Attributes
> > 
> > I don't know why people still want ACL's. There were noises about them for 
> > samba, but I'v enot heard anything since. Are vendors using this?
> 
> Because People Are Stupid(tm).  Because it's cheaper to put "ACL support: yes"
> in the feature list under "Security" than to make sure than userland can cope
> with anything more complex than  "Me Og.  Og see directory.  Directory Og's.
> Nobody change it".  C.f. snake oil, P.T.Barnum and esp. LSM users

It's nearly useless in a Unix-only context, true, however there's a rather
serious impedance mismatch for serving files to Windows that this
addresses. Emulating ACLs on the fly with groups to fit into the
Windows model is mostly doable but ain't pretty. 

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
