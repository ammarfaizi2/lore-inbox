Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753725AbWKFX23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbWKFX23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 18:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753925AbWKFX23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 18:28:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11472 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753723AbWKFX22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 18:28:28 -0500
Message-ID: <454FC514.1060403@redhat.com>
Date: Mon, 06 Nov 2006 17:28:20 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to PAGE_CACHE_SIZE
References: <454FAE0A.3070409@redhat.com> <20061106230547.GA29711@infradead.org> <454FC20F.8040206@redhat.com> <20061106231749.GB29711@infradead.org>
In-Reply-To: <20061106231749.GB29711@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Nov 06, 2006 at 05:15:27PM -0600, Eric Sandeen wrote:
>>> I agree with the conclusion, but the patch is incomplete.  You went down
>>> all the way to find out what the fileystems do in this messages, so add
>>> the hunks to override the defaults for non-standard filesystems to the
>>> patch aswell to restore the pre-inode diet state.
>> Well, agreed.  I put 80% or more back to pre-patch state, but not all.
>> :)  So it's less broken with my patch than without, so at least it's
>> moving forward.  So... Ted's patches get in w/o fixing up all the other
>> filesystems (left as an exercise to the patch reader) but mine can't? :)
> 
> It's because no reviwer noticed the breakage Ted put in ;-)  I think if
> you really refused to do the remaining 20% we can try to pressured Ted to
> do it and if that doesn't work I'll just do it myself because I'll be
> tired of arguing at that point.. 

eh, I'll sign up to do it when I get a moment, I won't refuse :)

Just had to notice that 2 patches already went in without the
requirement to "fix everything else" :)

It would be nice to get the "fix most of it" patch in sooner than later,
though.

-Eric
