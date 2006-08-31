Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWHaRmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWHaRmc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWHaRmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:42:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31719 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932405AbWHaRmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:42:31 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060831102127.8fb9a24b.akpm@osdl.org> 
References: <20060831102127.8fb9a24b.akpm@osdl.org>  <20060830135503.98f57ff3.akpm@osdl.org> <20060830125239.6504d71a.akpm@osdl.org> <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com> <27414.1156970238@warthog.cambridge.redhat.com> <9849.1157018310@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no,
       hch@infradead.org
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock sharing [try #13] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 31 Aug 2006 18:42:08 +0100
Message-ID: <11507.1157046128@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Trond merged the large nfs-affecting ones; I don't know if he intends to
> handle the non-nfs bulk of the work though.

There is one large NFS affecting patch left: namely the one that makes NFS use
FS-Cache.  I presume that requires Trond's agreement to merge.

> Your CONFIG_BLOCK patches did a decent job of trashing your
> fs-cache-make-kafs-* patches, btw.  What's up with that?  OK, it's sensible
> for people to work against mainline but the net effect of doing that is to
> create a mess for other people to clean up.

Hmmm...  Jens wanted my block patches against his tree; you wanted my NFS
patches against Trond's NFS tree.  I guess I should try stacking the whole
lot, but against what?  And who carries the fixes?  A patch to fix this
problem may well only apply to a tree that's the conjunction of both:-/

> If Christoph acks them then I can send them to Trond or Linus, at Trond's
> option.
> 
> Or I can butt out, drop the patches, wait for them to turn up in Trond's
> tree, at your option.

Trond, Christoph?  Any thoughts?


David
