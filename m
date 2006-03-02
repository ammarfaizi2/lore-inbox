Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbWCBR5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWCBR5i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWCBR5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:57:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63969 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751129AbWCBR5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:57:37 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060302092854.2818e98c.akpm@osdl.org> 
References: <20060302092854.2818e98c.akpm@osdl.org>  <20060301162113.774d1745.akpm@osdl.org> <20060301173617.16639.83553.stgit@warthog.cambridge.redhat.com> <3718.1141299945@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Permit NFS superblock sharing [try #2] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 02 Mar 2006 17:57:18 +0000
Message-ID: <13560.1141322238@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Why do you assume that?

Why shouldn't I? If I build my patches against Trond's tree instead of Linus's,
it may still not apply to your -mm tree.

> nfs-apply-mount-root-dentry-override-to-filesystems:
> 3 out of 10 hunks FAILED -- saving rejects to file fs/nfs/inode.c.rej

Would it help you if I split the NFS bits out of patch 2 into a separate patch?

> Ordinarily, yes.  But for something like this you should work against the
> NFS development tree, not against mainline.

Okay.

David
