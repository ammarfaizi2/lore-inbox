Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSHAPj5>; Thu, 1 Aug 2002 11:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSHAPj5>; Thu, 1 Aug 2002 11:39:57 -0400
Received: from dsl-65-186-160-165.telocity.com ([65.186.160.165]:44550 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id <S315517AbSHAPj4>; Thu, 1 Aug 2002 11:39:56 -0400
Date: Thu, 1 Aug 2002 11:39:37 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Schwartz <davids@webmaster.com>, trond.myklebust@fys.uio.no,
       Christoph Hellwig <hch@infradead.org>, Bill Davidsen <davidsen@tmr.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] The List, pass #2
Message-ID: <20020801153936.GA17759@fieldses.org>
References: <1028209375.14871.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028209375.14871.3.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 02:42:55PM +0100, Alan Cox wrote:
> On Thu, 2002-08-01 at 10:33, David Schwartz wrote:
> > 
> > >An additional problem with a BSD like license is that it makes no
> > >statement on patents - regrettably a critical issue now days in the
> > >USSA. That means nothing prevents CITI from providing BSD licensed code
> > >and then 6 months later sueing everyone who used it. I don't see CITI
> > >doing that but the basic problem is still there.
> > 
> > 	Sure something prevents them. You can't induce people to violate your patent 
> > and then complain when they do what you induced them to do. Remember Rambus?
> 
> You don't have to induce them, you just announce release 1 and wait for
> someone to pick it up and merge it.

I don't know about that.  But I don't accept the claim that the
GPL's statements on patents adds any additional protection against a
copyright-owner later deciding to pursue a patent.  Here's the relevant
clause of the GPL:

  7. If, as a consequence of a court judgment or allegation of patent
  infringement or for any other reason (not limited to patent issues),
  conditions are imposed on you (whether by court order, agreement or
  otherwise) that contradict the conditions of this License, they do not
  excuse you from the conditions of this License.  If you cannot
  distribute so as to satisfy simultaneously your obligations under this
  License and any other pertinent obligations, then as a consequence you
  may not distribute the Program at all.  For example, if a patent
  license would not permit royalty-free redistribution of the Program by
  all those who receive copies directly or indirectly through you, then
  the only way you could satisfy both it and this License would be to
  refrain entirely from distribution of the Program.

Note that the "you" referred to in this clause is the licensee, not the
copyright owner.  Thus the effect of this clause is only to prevent
licensees from redistributing a work with patent problems.

In the case of a contributor to a project like the Linux kernel,
however, two things are happening at once:

  1. The contributor is creating original works which are copyright to
     that contributor.
  2. The contributor is creating a derived work of the Linux kernel,
     which is copyright to a whole bunch of other people.

The only thing that permits a contributor like CITI to create and
distribute derived works of the Linux kernel is the contributor's
acquiescence to the GPL on *other* people's works.  So if CITI a year
from now decided to start collecting royalties on some hypothetical
patent, it would be violating the GPL on other people's code; the
license on the particular files that CITI added would be irrelevant.

Feel free to correct me if I've missed something here.
--Bruce Fields
