Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbUKPQ11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUKPQ11 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUKPQ11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:27:27 -0500
Received: from mail.tmr.com ([216.238.38.203]:7947 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262014AbUKPQ1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:27:19 -0500
Date: Tue, 16 Nov 2004 11:18:05 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Ed Tomlinson <edt@aei.ca>
cc: Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
In-Reply-To: <200410261719.56474.edt@aei.ca>
Message-ID: <Pine.LNX.3.96.1041116111111.21955E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004, Ed Tomlinson wrote:

> On Tuesday 26 October 2004 07:09, Massimo Cetra wrote:
> > > On Tuesday 26 October 2004 01:40, Chuck Ebbert wrote:
> > > > Bill Davidsen wrote:
> > > > 
> > > > > I don't see the need for a development kernel, and it is 
> > > desirable 
> > > > > to be
> > > > > able to run kernel.org kernels.
> > > > 
> > > >   Problem is, kernel.org 'release' kernels are quite buggy.  For 
> > > > example 2.6.9 has a long list of bugs:
> > > >
> > > >   Sure, the next release will (may?) fix these bugs, but it will 
> > > > definitely add a whole set of new ones.
> > > 
> > 
> > > To my mind this just points out the need for a bug fix 
> > > branch.   e.g. a
> > > branch containing just bug/security fixes against the current 
> > > stable kernel.  It might also be worth keeping the branch 
> > > active for the n-1 stable kernel too.
> > 
> > To my mind, we only need to make clear that a stable kernel is a stable
> > kernel.
> > Not a kernel for experiments.
> > 
> > To my mind, stock 2.6 kernels are nice for nerds trying patches and
> > willing to recompile their kernel once a day. They are not suitable for
> > servers. Several times on testing machines, switching from a 2.6 to the
> > next one has caused bugs on PCI, acpi, networking and so on.
> > 
> > The direction is lost. How many patchsets for vanilla kernel exist? 
> > 
> > Someone has decided that linux must go on desktops as well and
> > developing new magnificent features for desktop users is causing serious
> > problems to the ones who use linux at work on production servers.
> > 
> > 2.4 tree is still the best solution for production.
> > 2.6 tree is great for gentoo users who like gcc consuming all CPU
> > (maxumum respect to gentoo but I prefer debian)
> 
> The issue is that Linus _has_ changed the development model.  What we have
> now is more flexable and much more responsive to changes.  This does 
> lead to stable releases that are not quite a stable as some of the previous
> stable series...  This is why I suggest a fix/security branch.  The idea being
> that after a month or so of fixes etc it will be a very stable kernel and it will
> not have slowed down development.

Linus doesn't want a stable branch, unfortunately. Many people have
suggested that 2.7 be opened, but it isn't going to happen until and
unless the politics change. The kernel.org kernels are fine if they happen
to works for you, but new features just keep being dropped into it like a
development kernel.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

