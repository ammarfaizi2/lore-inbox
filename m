Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVCCLtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVCCLtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVCCLLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:11:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:35759 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261558AbVCCKq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:46:26 -0500
Date: Thu, 3 Mar 2005 02:45:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: jgarzik@pobox.com, greg@kroah.com, torvalds@osdl.org,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303024542.33d684fd.akpm@osdl.org>
In-Reply-To: <20050303102655.GC31559@wiggy.net>
References: <20050302230634.A29815@flint.arm.linux.org.uk>
	<42265023.20804@pobox.com>
	<Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	<20050303002047.GA10434@kroah.com>
	<Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>
	<20050303081958.GA29524@kroah.com>
	<4226CCFE.2090506@pobox.com>
	<20050303090106.GC29955@kroah.com>
	<4226D655.2040902@pobox.com>
	<20050303021506.137ce222.akpm@osdl.org>
	<20050303102655.GC31559@wiggy.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman <wichert@wiggy.net> wrote:
>
> Previously Andrew Morton wrote:
>  > I'd say that mainline kernel.org for the past couple of years has been a
>  > technology, not a product.
> 
>  If you consider mainline a technology and distributions your main users,
>  what is the use of a stable release every months or two months?

I don't know, because we've never tried it.  One can only speculate, and
I'd speculate that the kernel would end up pretty crappy because there
would never be a point in time when the thing was sufficiently usable.

The need to periodically lock things down and concentrate on stability and
generally get our act together every couple of months is good discipline
even if we're only making a technology, IMO.  And it gets more testers.

>  So continueing that thought pattern; why not go for something like 6
>  month release cycles? That seems to fit with a distro release cycles.

That could work.  The releases are slowing down as we spend longer wringing
out bugs.  Six months would be a bit excessive though.

But before solutions are discussed, we need to work out what the question was.

What are we trying to fix, and why?

>  > So I'd suspect that on average, kernel releases are getting more stable. 
>  > But the big big problem we have is that even though we fixed ten things for
>  > each one thing we broke, those single breakages tend to be prominent, and
>  > people get upset.  It's fairly bad PR that Dell Inspiron keyboards don't
>  > work in 2.6.11, for example...
> 
>  same for latitude keyboards after a resume I just discovered :(

You know what to do ;)
