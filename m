Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVKVNrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVKVNrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 08:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbVKVNrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 08:47:11 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:27802 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964911AbVKVNrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 08:47:10 -0500
Date: Tue, 22 Nov 2005 08:46:55 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Paul Jackson <pj@sgi.com>
cc: Matthew Frost <artusemrys@sbcglobal.net>, marc@osknowledge.org,
       greg@kroah.com, linux-kernel@vger.kernel.org, rdunlap@xenotime.net,
       xose.vazquez@gmail.com
Subject: Re: [RFC] Documentation dir is a mess
In-Reply-To: <20051122011845.32bab1d6.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0511220839020.12166@gandalf.stny.rr.com>
References: <20051121173404.GA7886@stiffy.osknowledge.org>
 <20051122060648.8827.qmail@web81904.mail.mud.yahoo.com> <20051122011845.32bab1d6.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Nov 2005, Paul Jackson wrote:

> > The documents
> > that exist may not conform themselves well to that sort of division,
> > necessarily.
>
> Good point, not just for -that- sort of division, but perhaps for
> any sort.
>
> I am skeptical that there is much value to be added to the current
> hodge podge of documents in the Documentation directory by rearranging
> them in some grand scheme.
>
> Certainly there is some value that can be subtracted -- just changing
> it will result in some minor cost to each of us, adjusting to the
> changes.  The greater the changes, the more aggressive the effort to
> categorize it, the greater this distributed cost of change.
>
> Perhaps what we have is deeper than just improperly arranged Docs.
> The content of the Docs may have too much variation in depth, topic,
> breadth, organization, style and such to be well suited to a deep
> structure.
>
> Maybe it looks disorganized because it is -- more than just skin deep.
>

Exactly why the documents _should_ be rearranged.  If you expect the
contents of the documents to be cleaned up first, that wont happen. But if
you make an hierarchy out of the current Document design (which there is
some attempt to do so already there), then later changes can be to start
breaking up the documents that have too much at every level into smaller
versions where they belong.

So the hierarchy can be like an outline. The first stab at this should
just be to make the catagories that are needed, and still allow those
catagories themselves be able to change.  Then, if necessary, modify the
documents.

This would need to be done in a step by step basis.  Although the first
round can be the creation of the document directories with the attempt of
placing every document in the toplevel Document directory into a lower
directory.  Then we can slowly start fixing them one by one.

Like I said, I would be willing to start reading each document and see
where it might fit.  You may not agree with my decision, but then we can
discuss it and find a proper fit.

So the question remains, how does one start this?  Should someone just
take a crack at it, submit it, and then let the games begin?

-- Steve

