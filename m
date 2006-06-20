Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWFTVD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWFTVD5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWFTVD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:03:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20911 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751078AbWFTVD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:03:57 -0400
Date: Tue, 20 Jun 2006 14:03:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@namei.org>
Cc: dhowells@redhat.com, torvalds@osdl.org, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] [PATCH 0/6] Keys: Key management updates  [try #3]
Message-Id: <20060620140337.f7e57e9a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606201642050.1262@d.namei>
References: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0606201642050.1262@d.namei>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 16:44:16 -0400 (EDT)
James Morris <jmorris@namei.org> wrote:

> On Tue, 20 Jun 2006, David Howells wrote:
> 
> > These patches update a few key management related things, mainly security
> > related.  They have the following prerequisite patches from Andrew Morton's -mm
> > tree:
> > 
> > 	selinux-add-hooks-for-key-subsystem.patch
> > 	keys-fix-race-between-two-instantiators-of-a-key.patch
> 
> When do you think these patches will move from -mm into mainline?

I prefer to start the -mm merging in the second week of the merge window,
after the git trees have gone.

a) because that's the order in which the patches are staged

b) because that's the way in which they were tested: -mm patches without
   the presence of the git trees is basically untested code.

c) because I'm more able to handle rejects and other such crap than git
   victims^Wusers.

But sometimes I get bored and merge stuff early anyway.

> I ask because I've got a bunch of SELinux patches lined up behind this 
> patchset, which we're aiming for 2.6.18 inclusion.

OK, I'll move those two up into the i-got-bored batch, aim for tomorrow.
