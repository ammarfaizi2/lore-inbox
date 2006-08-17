Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWHQMOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWHQMOl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWHQMOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:14:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25039 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932172AbWHQMOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:14:38 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060817004219.44c45bbd.akpm@osdl.org> 
References: <20060817004219.44c45bbd.akpm@osdl.org>  <1155743399.5683.13.camel@localhost> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <5910.1155741329@warthog.cambridge.redhat.com> <13319.1155744959@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com,
       Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's list 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 17 Aug 2006 13:13:29 +0100
Message-ID: <3930.1155816809@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> VFS: Busy inodes after unmount of 0:15. Self-destruct in 5 seconds.  Have a
> nice day...

Sigh.

Guess what?  I don't see that...

After you've done the "ls -l", can you run:

	cat /proc/mounts
	cat /proc/fs/nfsfs/*

Before unmounting, and then can you run:

	cat /proc/fs/nfsfs/*

Again afterwards?

David
