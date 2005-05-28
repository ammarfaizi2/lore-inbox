Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVE1KpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVE1KpT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 06:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVE1KpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 06:45:19 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:10501 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262674AbVE1KpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 06:45:13 -0400
Date: Sat, 28 May 2005 03:50:03 -0700
To: Bill Huey <bhuey@lnxw.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050528105003.GA3491@nietzsche.lynx.com>
References: <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <20050528065500.GA17005@infradead.org> <20050528102259.GA3072@nietzsche.lynx.com> <20050528103417.GA3390@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050528103417.GA3390@nietzsche.lynx.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2005 at 03:34:17AM -0700, Bill Huey wrote:
> On Sat, May 28, 2005 at 03:22:59AM -0700, Bill Huey wrote:
> > On Sat, May 28, 2005 at 07:55:00AM +0100, Christoph Hellwig wrote:
> > > You're on crack as usual, but today you go much too far.  XFS doesn't
> > > ahave anything to do with you're so Hard RT pipedreams.  The so-called
> > > 'RT' subvolulme only provides a more determinitistic block allocator.
> > > GRIO doesn't require any RT guarantees, it's entirely about I/O scheduling
> > > and has been ported to various operating systems with sane locking semantics.
> > 
> > I actually when I talked to the SGI folks about 5 years ago at Usenix
> > I got a different story where they really were thinking about hacking
> > a tasklet to handle some of this IO stuff going. So I'm going to bet
> > that you're wrong about this based on that conversation.
> 
> I'd like to add that 16x way SGI boxes can play and record something like
> 300+ individual streams that are frame accurate. An SGI buddy of mine
> mention that CNN actually uses such a box to handle all of their video
> data in real time.
 
Also, to continue this open minded discussion and reply of yours. How do
you think IO is submitted to a system like that so that those guarantees
are met ? Obivously some kind deterministic mechanism is pushing those
requests to the wire.

bill

