Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbSJaDWC>; Wed, 30 Oct 2002 22:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265167AbSJaDVH>; Wed, 30 Oct 2002 22:21:07 -0500
Received: from [198.149.18.6] ([198.149.18.6]:34967 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265153AbSJaDTm>;
	Wed, 30 Oct 2002 22:19:42 -0500
Subject: Re: What's left over.
From: Stephen Lord <lord@sgi.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 30 Oct 2002 21:21:03 -0600
Message-Id: <1036034465.1058.25.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-30 at 20:31, Linus Torvalds wrote:
> 
> On Thu, 31 Oct 2002, Rusty Russell wrote:
> > 
> > 	Here is the list of features which have are being actively
> > pushed, not NAK'ed, and are not in 2.5.45.  There are 13 of them, as
> > appropriate for Halloween.
> 
> I'm unlikely to be able to merge everything by tomorrow, so I will 
> consider tomorrow a submission deadline to me, rather than a merge 
> deadline. That said, I merged everything I'm sure I want to merge today, 
> and the rest I simply haven't had time to look at very much.
> 

> 
> > ext2/ext3 ACLs and Extended Attributes
> 
> I don't know why people still want ACL's. There were noises about them for 
> samba, but I'v enot heard anything since. Are vendors using this?
> 

There are a fair number of NAS vendors who do linux boxes with Samba
and XFS because of the ACL support, Quantum being the one Tridge now
works for by the way. The reason they want it is so they can support
the features NT folks are used to having in their file servers.
Now, we could just let the NT folks use NT servers instead....

Even getting XFS ACLs running in 2.5 requires part of this patch set.

Steve


