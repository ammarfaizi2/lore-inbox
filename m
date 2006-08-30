Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWH3UzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWH3UzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 16:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWH3UzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 16:55:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751538AbWH3UzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 16:55:17 -0400
Date: Wed, 30 Aug 2006 13:55:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
 sharing [try #13]
Message-Id: <20060830135503.98f57ff3.akpm@osdl.org>
In-Reply-To: <27414.1156970238@warthog.cambridge.redhat.com>
References: <20060830125239.6504d71a.akpm@osdl.org>
	<20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	<27414.1156970238@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 21:37:18 +0100
David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > > These patches add local caching for network filesystems such as NFS and AFS.
> > 
> > <fercrissake>
> > 
> > Not interested.  Please go learn quilt, send incremental patches.
> 
> What's quilt able to do that StGIT can't?  AFAICT from quilt's manpage, it
> can't mail incremental patches, so how does it help anyway?
> 

It was just a suggestion.  Please:

- test the patches which are presently in -mm.  I don't even know if they
  work, and we prefer to send Linus working stuff.

- Send fine-grained incremental patches.  It's OK to do complete
  replacement patchsets when the code is new, but this stuff is supposed to
  be stabilised.

  It took me quite a lot of time to extract the incremental patches out
  of try#12 and I don't want to do it again, plus it's just another step in
  which errors can be introduced.

Why incremental patches?

- So we can see what changed and don't have to re-review the whole thing

- So the recipient doesn't have to re-fix the same pile of rejects each time.

- So fixes which came in via other sources don't get lost.
