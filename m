Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268663AbUHYU2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268663AbUHYU2C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268588AbUHYUYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:24:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:38086 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268592AbUHYUWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:22:17 -0400
Subject: Re: silent semantic changes with reiser4
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <412CEE38.1080707@namesys.com>
References: <20040824202521.GA26705@lst.de>  <412CEE38.1080707@namesys.com>
Content-Type: text/plain
Message-Id: <1093465334.21878.231.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 25 Aug 2004 16:22:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-25 at 15:53, Hans Reiser wrote:
> I had not intended to respond to this because I have nothing positive to 
> say, but Andrew said I needed to respond and suggested I should copy 
> Linus. Sigh.
> 
> Dear Christoph,
> 
> Let me see if I can summarize what you and your contingent are saying, 
> and if I misconstrue anything, let me know.;-)
> 
Just for fun why don't we look at the way things are today:

1) reiser4 has semantics that do belong at the VFS level.  They weren't
implemented at the VFS level for a variety of reasons, none of which
really matter right now.

2) new kernel patches that fragment the application developers between
apis are a bad thing.  There does need to be one interface here, and it
is in Hans' best interest to unify his work by working with people to
introduce new kernel wide apis.

This starts with exactly what Christoph described in writing a short
summary of how you want things to work today.  Since we can't resist,
we'll also go ahead and rehash all the old flame wars over this, but try
to include some new ideas about where you want to see the reiser4
interfaces in 6 months as well.

-chris



