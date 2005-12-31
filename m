Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbVLaPbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVLaPbV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 10:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVLaPbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 10:31:21 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:49116 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964989AbVLaPbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 10:31:21 -0500
Subject: Re: userspace breakage
From: Steven Rostedt <rostedt@goodmis.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, davej@redhat.com,
       jmerkey@wolfmountaingroup.com
In-Reply-To: <1136018010.2901.2.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	 <20051229202852.GE12056@redhat.com>
	 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	 <20051229224103.GF12056@redhat.com>
	 <43B453CA.9090005@wolfmountaingroup.com>
	 <Pine.LNX.4.64.0512291541420.3298@g5.osdl.org>
	 <43B46078.1080805@wolfmountaingroup.com>
	 <Pine.LNX.4.64.0512291603500.3298@g5.osdl.org>
	 <1135974176.6039.71.camel@localhost.localdomain>
	 <20051230154954.47be93a3.akpm@osdl.org>
	 <1136018010.2901.2.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 10:30:30 -0500
Message-Id: <1136043030.6039.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 09:33 +0100, Arjan van de Ven wrote:
> On Fri, 2005-12-30 at 15:49 -0800, Andrew Morton wrote:
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Thu, 2005-12-29 at 16:10 -0800, Linus Torvalds wrote:
> > > 
> > > > Stuff outside the kernel is almost always either (a) experimental stuff 
> > > > that just isn't ready to be merged or (b) tries to avoid the GPL.
> > > 
> > > (c) So damn specialized that it's not worth even trying to merge.
> > 
> > Or drivers for highly specialised/customised hardware.
> 
> that's not really an excuse.. there's drivers in the tree for which only
> 4 boards ever existed. There still is value in having those in the tree,
> if only for the "other side" of the API to be able to see usage
> patterns...

Yeah, but maybe Andrew isn't even talking about those boards.  I know
when I worked for Lockheed, they had a bunch of custom boards that were
for one specific project.  There would really be no point in pushing a
driver into the mainline that is used by one board for one project.

But then again, I'm not Andrew, and maybe he _is_ talking about the
drivers used by only four boards.

-- Steve


