Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVCCNNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVCCNNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 08:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVCCNNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 08:13:30 -0500
Received: from mail.aei.ca ([206.123.6.14]:32221 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261601AbVCCNNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 08:13:22 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFD: Kernel release numbering
Date: Thu, 3 Mar 2005 08:13:19 -0500
User-Agent: KMail/1.7.2
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503030813.20223.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 22:37, Linus Torvalds wrote:
> 
> On Wed, 2 Mar 2005, Jeff Garzik wrote:
> > 
> > If we want a calming period, we need to do development like 2.4.x is 
> > done today.  It's sane, understandable and it works.
> 
> No. It's insane, and the only reason it works is that 2.4.x is a totally
> different animal. Namely it doesn't have the kind of active development AT
> ALL any more. It _only_ has the "even" number kind of things, and quite 
> frankly, even those are a lot less than 2.6.x has.
> 
> > 2.6.x-pre: bugfixes and features
> > 2.6.x-rc: bugfixes only
> 
> And the reason it does _not_ work is that all the people we want testing 
> sure as _hell_ won't be testing -rc versions.
> 
> That's the whole point here, at least to me. I want to have people test 
> things out, but it doesn't matter how many -rc kernels I'd do, it just 
> won't happen. It's not a "real release".
> 
> In contrast, making it a real release, and making it clear that it's a 
> release in its own right, might actually get people to use it. 

It seems to me that the problem is not the numbering scheme.  We _will_
experience the same issues no mater what scheme we use...  The way I see
it is that we need a way to tell how much testing a given release has had.
I would suggest an opt outable scheme that records boot (via an email 
for instance) and asks for comments after a day or two.  With this sort of 
method we would _know_ just how much testing is done.  We eventually 
could start to relate the amount of testing to just how stable the kernel 
will be.

Comments
Ed Tomlinson
