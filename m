Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVBOOGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVBOOGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 09:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVBOOGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 09:06:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15045 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261726AbVBOOFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 09:05:55 -0500
To: lm@bitmover.com (Larry McVoy)
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK] upgrade will be needed
References: <20050214174932.GB8846@bitmover.com>
	<1108406835.8413.20.camel@localhost.localdomain>
	<20050214190137.GB16029@bitmover.com>
	<1108415541.8413.48.camel@localhost.localdomain>
	<20050214231148.GP13174@bitmover.com>
	<1108425420.8413.78.camel@localhost.localdomain>
	<20050215000028.GS13174@bitmover.com>
	<1108426451.8413.84.camel@localhost.localdomain>
	<20050215003535.GB32158@bitmover.com>
	<1108429259.8413.99.camel@localhost.localdomain>
	<20050215030145.GB6288@bitmover.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 15 Feb 2005 12:05:28 -0200
In-Reply-To: <20050215030145.GB6288@bitmover.com>
Message-ID: <ory8dpzzo7.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 15, 2005, lm@bitmover.com (Larry McVoy) wrote:

> For those who don't know, bk changes -v is output in time sorted
> order of changesets with the changeset comments then each file's
> comments like the output below.

> as Roman/Pavel/et al have pointed out sometimes the commits in the
> CVS tree are too coarse if the cset you want is a merge of 20
> changesets on a branch.

How would the `bk changes -v ' output look like for such a merge of 20
changesets on a branch?  Would it list the 20 merged changesets?

Also, would the changeset ids (ChangeSet@1.2044) match the revision
IDs in the CVS tree?

If so, it looks like this would provide the very bit of information
that I feel to be missing from the publicly-available Linux
repository.

> But for people trying to easily track the head the tarball server might
> be just the ticket.

Any chance of having such tarballs offered from an rsync server,
compressed with gzip --rsyncable?

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
