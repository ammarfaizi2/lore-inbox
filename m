Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbULBGfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbULBGfY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 01:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbULBGfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 01:35:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:62868 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261509AbULBGfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 01:35:16 -0500
Date: Wed, 1 Dec 2004 22:34:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, clameter@sgi.com, hugh@veritas.com,
       benh@kernel.crashing.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and
 performance tests
Message-Id: <20041201223441.3820fbc0.akpm@osdl.org>
In-Reply-To: <41AEB44D.2040805@pobox.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
	<41AEB44D.2040805@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Linus Torvalds wrote:
> > Ok, consider me convinced. I don't want to apply this before I get 2.6.10 
> > out the door, but I'm happy with it. I assume Andrew has already picked up 
> > the previous version.
> 
> 
> Does that mean that 2.6.10 is actually close to the door?
> 

We need an -rc3 yet.  And I need to do another pass through the
regressions-since-2.6.9 list.  We've made pretty good progress there
recently.  Mid to late December is looking like the 2.6.10 date.

We need to be be achieving higher-quality major releases than we did in
2.6.8 and 2.6.9.  Really the only tool we have to ensure this is longer
stabilisation periods.

Of course, nobody will test -rc3 and a zillion people will test final
2.6.10, which is when we get lots of useful bug reports.  If this keeps on
happening then we'll need to get more serious about the 2.6.10.n process.

Or start alternating between stable and flakey releases, so 2.6.11 will be
a feature release with a 2-month development period and 2.6.12 will be a
bugfix-only release, with perhaps a 2-week development period, so people
know that the even-numbered releases are better stabilised.

We'll see.  It all depends on how many bugs you can fix in the next two
weeks ;)

