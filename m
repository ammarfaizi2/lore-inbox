Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWIDSUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWIDSUq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 14:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWIDSUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 14:20:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36066 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751419AbWIDSUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 14:20:45 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060901093451.87aa486d.akpm@osdl.org> 
References: <20060901093451.87aa486d.akpm@osdl.org>  <20060831102127.8fb9a24b.akpm@osdl.org> <20060830135503.98f57ff3.akpm@osdl.org> <20060830125239.6504d71a.akpm@osdl.org> <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com> <27414.1156970238@warthog.cambridge.redhat.com> <9849.1157018310@warthog.cambridge.redhat.com> <9534.1157116114@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock sharing [try #13] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 04 Sep 2006 19:20:32 +0100
Message-ID: <18448.1157394032@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@osdl.org> wrote:

> I fixed it all up, I think.  Please review-and-test rc5-mm1

It seems to work okay, and the you seem to have made a change to fs/afs/file.c
that matches the one that I've made, so thanks.

> (including hot-fixes/ contents, which grows apace).

 (*) drivers-md-kconfig-fix-block-dependency.patch

     I ACK'd Adrian's patch, and the change it makes appears in Jens's block
     GIT tree, even if the patch itself does not AFAICT.

David
