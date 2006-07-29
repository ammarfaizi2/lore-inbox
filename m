Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbWG2LMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWG2LMv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 07:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWG2LMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 07:12:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59883 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932103AbWG2LMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 07:12:50 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060728230540.7358b435.akpm@osdl.org> 
References: <20060728230540.7358b435.akpm@osdl.org>  <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/30] Permit filesystem local caching and NFS superblock sharing [try #11] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Sat, 29 Jul 2006 12:12:31 +0100
Message-ID: <24563.1154171551@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > These patches make it possible to share NFS superblocks between related
> > mounts, where "related" means on the same server and FSID. Inodes and
> > dentries will be shared where the NFS filehandles are the same (for
> > example if two NFS3 files come from the same export but from different
> > mounts, such as is not uncommon with autofs on /home).
> 
> It's not clear why these were sent.

To try and elicit some feedback.

> The first 25 patches are, as far as I can tell, already in Trond's tree.
> Whether Trond has the correct versions of these is now anybody's guess...

He hasn't told me of any changes, but that doesn't mean he hasn't made any, I
suppose.

> "[PATCH 26/30] NFS: Use local caching" appears to be the first patch which
> isn't in Trond's tree, but it doesn't work due to significant changes in
> nfs_clear_inode().

Hmmm...

David
