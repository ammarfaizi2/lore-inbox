Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbSJaRud>; Thu, 31 Oct 2002 12:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbSJaRuZ>; Thu, 31 Oct 2002 12:50:25 -0500
Received: from mg02.austin.ibm.com ([192.35.232.12]:28627 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S265246AbSJaRuF>; Thu, 31 Oct 2002 12:50:05 -0500
Date: Thu, 31 Oct 2002 11:55:48 -0600 (CST)
From: Dave Craft <dcraft@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-general] Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210310737170.2035-100000@home.transmeta.com>
Message-ID: <Pine.A41.4.44.0210311128060.21482-100000@craft.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Linus Torvalds wrote:

> What I'm saying by "vendor driven" is that it has no relevance for the
> standard kernel, and since it has no relevance to that, then I have no
> incentives to merge it. The crash dump is only useful with people who
> actively look at the dumps, and I don't know _anybody_ outside of the
> specialized vendors you mention who actually do that.

  Unfortunately the vast majority of the customers I deal with
  buy a distribution and then put a kernel from kernel.org
  on.  I believe this comes about because of either needing fixes
  or function that appear in later kernels that have not made
  it to the distributions kernels yet.

  Even if the distribution included LKCD in their kernel,
  I lose lots of debug ability once customers switch over to
  kernel.org and no longer have the LKCD patch.

  Thus we are currently left with having to maintain LKCD patches for
  many arbitrary kernel.org kernels and convince customers to apply
  it BEFORE they start encountering problems that we'll have to look at.
  Application of patches that aren't automatically included in kernel.org
  rarely happens with our customer set (before problems occur),
  no matter how much we flag the issue to them up front.

  I realize that while my current capacity makes me fall into
  the 'vendor' support you speak of, I believe I am actually
  advocating its inclusion on behalf of real live customers.

  Vendors can and do actually help linux development, by screening,
  researching fixes, and or directly fixing lots of customer
  problems that you never have to deal with.  To do that, LKCD
  is the debug weapon of choice.

  I request you reconsider the inclusion of LKCD.

  Regards, Dave

	Mail : dave@austin.ibm.com	Phone : 512-838-8248

