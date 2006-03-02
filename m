Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751972AbWCBLp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbWCBLp4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 06:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWCBLp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 06:45:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11434 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751972AbWCBLpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 06:45:54 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060301162113.774d1745.akpm@osdl.org> 
References: <20060301162113.774d1745.akpm@osdl.org>  <20060301173617.16639.83553.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Permit NFS superblock sharing [try #2] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 02 Mar 2006 11:45:45 +0000
Message-ID: <3718.1141299945@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> The number of rejects gets into the "I'm not confident it'll work after
> this" territory.
> 
> Here's Trond's current diff:

I assume this is you applying these patches to your -mm tree (which contains
some of Trond's patches), rather than Linus's tree or Trond's tree.

Can you be more specific about which patches you've got problems with? Is it
mainly that patch 5/5 and little bits of patch 2/5 don't apply?

There's a problem here in that your tree is incompatible with Linus's tree in
various ways. I believe you've said before that you prefer the patches you're
given to have been made against Linus's tree... is that right?

Also, do you yet have a git tree holding your patchset? If not, have you
considered using stacked git (StGIT) to provide one?

David
