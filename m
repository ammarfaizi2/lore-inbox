Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbUJZMM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbUJZMM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 08:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbUJZML4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 08:11:56 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:9185 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262244AbUJZMIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 08:08:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rFIi0hcppQTUjqeyhHW1ZR6TmpnqVldj1MVDG2FfCimHczxqx2rbFOGCkvhqQ2F5mIbrXN0eYRVsBPK7CtTl62tedV19FMXgNLN7u4sm5RxcHSrCQR7t0nxxrZeZBeg7mDwVhhEvWFULMwMLZVfYNCHH4q0ZEhivpcZ+MEILuE0=
Message-ID: <4d8e3fd3041026050823d012dc@mail.gmail.com>
Date: Tue, 26 Oct 2004 14:08:36 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Massimo Cetra <mcetra@navynet.it>
Subject: Re: My thoughts on the "new development model"
Cc: Ed Tomlinson <edt@aei.ca>, Chuck Ebbert <76306.1226@compuserve.com>,
       Bill Davidsen <davidsen@tmr.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410260644.47307.edt@aei.ca>
	 <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 13:09:59 +0200, Massimo Cetra <mcetra@navynet.it> wrote:
> > On Tuesday 26 October 2004 01:40, Chuck Ebbert wrote:
> > > Bill Davidsen wrote:
> > >
> > > > I don't see the need for a development kernel, and it is
> > desirable
> > > > to be
> > > > able to run kernel.org kernels.
> > >
> > >   Problem is, kernel.org 'release' kernels are quite buggy.  For
> > > example 2.6.9 has a long list of bugs:
> > >
> > >   Sure, the next release will (may?) fix these bugs, but it will
> > > definitely add a whole set of new ones.
> >
> 
> > To my mind this just points out the need for a bug fix
> > branch.   e.g. a
> > branch containing just bug/security fixes against the current
> > stable kernel.  It might also be worth keeping the branch
> > active for the n-1 stable kernel too.
> 
> To my mind, we only need to make clear that a stable kernel is a stable
> kernel.
> Not a kernel for experiments.

2.6 is not an experimental kernel. Not at all.
 
> To my mind, stock 2.6 kernels are nice for nerds trying patches and
> willing to recompile their kernel once a day. They are not suitable for
> servers. Several times on testing machines, switching from a 2.6 to the
> next one has caused bugs on PCI, acpi, networking and so on.

I don't understand what you mean here. 
Did you report these problems to lkml ?
It's the firts time I heard about this kind of problems.
 
> The direction is lost. How many patchsets for vanilla kernel exist?

It was the same for 2.4. And that's not _BAD_, is _GOOD_.
 
> Someone has decided that linux must go on desktops as well and
> developing new magnificent features for desktop users is causing serious
> problems to the ones who use linux at work on production servers.

Who ?
 
> 2.4 tree is still the best solution for production.
> 2.6 tree is great for gentoo users who like gcc consuming all CPU
> (maxumum respect to gentoo but I prefer debian)

I'm sorry, but you sound like a troll...
 
-- 
Paolo
