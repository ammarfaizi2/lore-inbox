Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbUD1V6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUD1V6S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUD1V6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:58:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:7382 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261756AbUD1VzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 17:55:16 -0400
Date: Wed, 28 Apr 2004 14:57:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Olien <dmo@osdl.org>
Cc: thornber@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial patch to dm-io.c
Message-Id: <20040428145735.5596a74e.akpm@osdl.org>
In-Reply-To: <20040427224530.GA16850@osdl.org>
References: <20040427224530.GA16850@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olien <dmo@osdl.org> wrote:
>
> Here's trivial patches to dm-io.c.  Just adds static declarations, and adds
> dm_io_sync_bvec() to the list of EXPORT_SYMBOL functions.

Speaking of trivia...

Could you please avoid using content-free subjects such as "trivial patch
to dm-io.c"?  We know that it's a patch, and we can see what files it
touches.

Something like "dm-io.c: add static decls, export dm_io_sync_bvec()" would
be a more useful patch description.


It's better than "Updated CPU hotplug patches for IA64 [Patch 3/7]" though.
 Probably a third of the patches I receive have useless summaries and I
have to cook up meaningful ones for them.  Which is not a competely bad
thing but it is, on balance, best that the originator prepare the summary.

Make my life a little easier ;)  Thanks.
