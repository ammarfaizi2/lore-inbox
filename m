Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVDGRIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVDGRIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVDGRIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:08:16 -0400
Received: from smtp.istop.com ([66.11.167.126]:56797 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262467AbVDGRIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:08:10 -0400
From: Daniel Phillips <phillips@istop.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel SCM saga..
Date: Thu, 7 Apr 2005 13:09:22 -0400
User-Agent: KMail/1.7
Cc: David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <1112858331.6924.17.camel@localhost.localdomain> <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504071309.23230.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 April 2005 11:32, Linus Torvalds wrote:
> On Thu, 7 Apr 2005, David Woodhouse wrote:
> > On Wed, 2005-04-06 at 08:42 -0700, Linus Torvalds wrote:
> > > PS. Don't bother telling me about subversion. If you must, start
> > > reading up on "monotone". That seems to be the most viable alternative,
> > > but don't pester the developers so much that they don't get any work
> > > done. They are already aware of my problems ;)
> >
> > One feature I'd want to see in a replacement version control system is
> > the ability to _re-order_ patches, and to cherry-pick patches from my
> > tree to be sent onwards. The lack of that capability is the main reason
> > I always hated BitKeeper.
>
> I really disliked that in BitKeeper too originally. I argued with Larry
> about it, but Larry (correctly, I believe) argued that efficient and
> reliable distribution really requires the concept of "history is
> immutable". It makes replication much easier when you know that the known
> subset _never_ shrinks or changes - you only add on top of it.

However, it would be easy to allow reordering before "publishing" a revision, 
which would preserve immutability for all published revisions while allowing 
the patch _author_ the flexibility of reordering/splitting/joining patches 
when creating them.  In other words, a virtuous marriage of the BK model with 
Andrew's Quilt.

Regards,

Daniel
