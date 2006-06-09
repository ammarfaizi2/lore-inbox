Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWFIVl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWFIVl0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWFIVl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:41:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:49573 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932328AbWFIVlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:41:25 -0400
Message-ID: <4489EAFE.6090303@garzik.org>
Date: Fri, 09 Jun 2006 17:41:18 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: Gerrit Huizenga <gh@us.ibm.com>, Michael Poole <mdpoole@troilus.org>,
       Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <E1Fomsf-0007hZ-7S@w-gerrit.beaverton.ibm.com> <4489D36C.3010000@garzik.org> <20060609203523.GE10524@thunk.org>
In-Reply-To: <20060609203523.GE10524@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> And I'd also dispute with your "weren't really suited for the original
> ext2-style design" comment.  Ext2/3 was always designed to be
> extensible from the start, and we've successfully added features quite
> successfully for quite a while.

Although not the only disk format change, extents are a pretty big one. 
Will this be the last major on-disk format change?


>> Rather than taking another decade to slowly fix ext2 design decisions, 
>> why not move the process along a bit more rapidly?  Release early, 
>> release often...
> 
> I don't think it will be another decade, but yes, regardless of
> whether we do a code fork or not, it will take time.  Basically, you
> and the ext2 developers have a disagreement about whether or not a
> code fork will actually move the process along more quickly or not.
> Either way, we will be releasing early and often, so people can test
> it out and comment on it.  Releasing patches to LKML is just the first
> step in this process.

I don't see how a larger filesystem codebase could possibly move more 
quickly than a smaller codebase.  You'd have twice as many code paths to 
worry about.

	Jeff


