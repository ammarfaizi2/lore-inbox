Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUBTWSk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 17:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUBTWSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 17:18:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17052 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261317AbUBTWSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 17:18:38 -0500
From: Daniel Phillips <phillips@arcor.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Non-GPL export of invalidate_mmap_range
Date: Fri, 20 Feb 2004 17:16:02 -0500
User-Agent: KMail/1.5.4
Cc: paulmck@us.ibm.com, "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
References: <20040216190927.GA2969@us.ibm.com> <200402201535.47848.phillips@arcor.de> <20040220211732.A10079@infradead.org>
In-Reply-To: <20040220211732.A10079@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402201715.34315.phillips@arcor.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 February 2004 16:17, Christoph Hellwig wrote:
> On Fri, Feb 20, 2004 at 03:37:26PM -0500, Daniel Phillips wrote:
> > It does, thanks for the catch.  Please bear with me for a moment while I
> > reroll this, then hopefully we can move on to the more interesting
> > discussion of whether it's worth it.  (Yes it is :)
>
> What about to the more interesting question who needs it.  It think this
> whole discussion who needs what and which approach is better is pretty much
> moot as long as we don't have an intree users.

We settled that question in this case, see Paul's "surrender" above ;)

> Instead of wasting your time on different designs you should hurry of
> getting your filesystems encumbrance-reviewed, cleaned up and merged -
> with intree users we have a chance of finding the right API.  And your
> newly started dicussion shows pretty much that with only out of tree users
> we'll never get a sane API.

Again, we (everybody who cared to jump in) now agree on what is sane here, 
it's quite logical.  As for supplying background material so this makes sense 
to a wider group of people, sorry it's been on my to-do list for a while.  
Getting a DFS, namely Sistina GFS, into the tree is underway as you know from 
the press release, however turning the ship takes time.  Meanwhile, the api 
discussion can't wait because the rudder on that ship is even smaller.

Regards,

Daniel

