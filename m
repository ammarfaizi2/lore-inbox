Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWIARBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWIARBL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 13:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWIARBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 13:01:11 -0400
Received: from pat.uio.no ([129.240.10.4]:6282 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932205AbWIARBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 13:01:09 -0400
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060901093451.87aa486d.akpm@osdl.org>
References: <20060831102127.8fb9a24b.akpm@osdl.org>
	 <20060830135503.98f57ff3.akpm@osdl.org>
	 <20060830125239.6504d71a.akpm@osdl.org>
	 <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	 <27414.1156970238@warthog.cambridge.redhat.com>
	 <9849.1157018310@warthog.cambridge.redhat.com>
	 <9534.1157116114@warthog.cambridge.redhat.com>
	 <20060901093451.87aa486d.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 13:00:44 -0400
Message-Id: <1157130044.5632.87.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.121, required 12,
	autolearn=disabled, AWL 1.88, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 09:34 -0700, Andrew Morton wrote:

> nfs automounter submounts are still broken in Trond's tree, btw.  Are we stuck?

You mean autofs indirect maps?

I'll see if I can't get my hands on an selinux setup like yours in order
to do some debugging. AFAICS, the non-selinux case works fine, though.

Cheers,
  Trond

