Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265316AbUFBXaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbUFBXaT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265376AbUFBXaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:30:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:33735 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265316AbUFBXaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:30:15 -0400
Subject: Re: ext3_orphan_del may double-decrement bh->b_count
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Mahoney <jeffm@suse.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040602150614.005e939f.akpm@osdl.org>
References: <40BE3235.5060906@suse.com>
	 <20040602150614.005e939f.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1086219035.22636.3524.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 02 Jun 2004 19:30:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-02 at 18:06, Andrew Morton wrote:
> Jeff Mahoney <jeffm@suse.com> wrote:
> >
> > Chris Mason and I ran across this one while hunting down another bug.
> 

> What was the "other bug"?

We've got many names for it, but none that could be posted here ;-)
Looks like HP came up with a simplified test case:

http://sourceforge.net/mailarchive/forum.php?thread_id=4536665&forum_id=6379

I've got machines trying to reproduce now.

-chris


