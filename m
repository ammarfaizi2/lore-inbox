Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbUJZLKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbUJZLKx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUJZLKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:10:53 -0400
Received: from [213.188.213.77] ([213.188.213.77]:32959 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S262230AbUJZLKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:10:11 -0400
From: "Massimo Cetra" <mcetra@navynet.it>
To: "'Ed Tomlinson'" <edt@aei.ca>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>
Cc: "'Bill Davidsen'" <davidsen@tmr.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: My thoughts on the "new development model"
Date: Tue, 26 Oct 2004 13:09:59 +0200
Message-ID: <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <200410260644.47307.edt@aei.ca>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tuesday 26 October 2004 01:40, Chuck Ebbert wrote:
> > Bill Davidsen wrote:
> > 
> > > I don't see the need for a development kernel, and it is 
> desirable 
> > > to be
> > > able to run kernel.org kernels.
> > 
> >   Problem is, kernel.org 'release' kernels are quite buggy.  For 
> > example 2.6.9 has a long list of bugs:
> >
> >   Sure, the next release will (may?) fix these bugs, but it will 
> > definitely add a whole set of new ones.
> 

> To my mind this just points out the need for a bug fix 
> branch.   e.g. a
> branch containing just bug/security fixes against the current 
> stable kernel.  It might also be worth keeping the branch 
> active for the n-1 stable kernel too.

To my mind, we only need to make clear that a stable kernel is a stable
kernel.
Not a kernel for experiments.

To my mind, stock 2.6 kernels are nice for nerds trying patches and
willing to recompile their kernel once a day. They are not suitable for
servers. Several times on testing machines, switching from a 2.6 to the
next one has caused bugs on PCI, acpi, networking and so on.

The direction is lost. How many patchsets for vanilla kernel exist? 

Someone has decided that linux must go on desktops as well and
developing new magnificent features for desktop users is causing serious
problems to the ones who use linux at work on production servers.

2.4 tree is still the best solution for production.
2.6 tree is great for gentoo users who like gcc consuming all CPU
(maxumum respect to gentoo but I prefer debian)

Massimo Cetra

