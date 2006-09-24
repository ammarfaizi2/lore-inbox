Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWIXWg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWIXWg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWIXWg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:36:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751301AbWIXWg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:36:26 -0400
Date: Sun, 24 Sep 2006 15:36:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Mark Fasheh <mark.fasheh@oracle.com>
cc: Andrew Morton <akpm@osdl.org>, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [git patches] ocfs2 post 2.6.18 features
In-Reply-To: <20060924221115.GF32106@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.64.0609241532140.3952@g5.osdl.org>
References: <20060924221115.GF32106@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, pulled, and pushed out.

And btw, I appreciate how you separately explained the fs/namei.c change, 
together with the diff for just that part. This is a prime example of how 
to make things easier for me to verify, when I see something touching a 
generic file. Thanks.

I do have a small nit: when you ask me to pull, you did:

> Please pull from 'upstream-linus' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git

I really prefer to see the branch-name at the end of the line (don't worry 
if it's more than 80 characters), because that way I don't make the 
mistake of cutting-and-pasting the git URL, and forgetting the branch.

So if you can update your "please pull" script to do that, I'd be even 
happier.

		Linus
