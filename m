Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVCCK1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVCCK1D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVCCK1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:27:03 -0500
Received: from levante.wiggy.net ([195.85.225.139]:28340 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262404AbVCCK06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:26:58 -0500
Date: Thu, 3 Mar 2005 11:26:55 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, greg@kroah.com, torvalds@osdl.org,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303102655.GC31559@wiggy.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, greg@kroah.com, torvalds@osdl.org,
	rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
References: <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com> <20050303090106.GC29955@kroah.com> <4226D655.2040902@pobox.com> <20050303021506.137ce222.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303021506.137ce222.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Andrew Morton wrote:
> I'd say that mainline kernel.org for the past couple of years has been a
> technology, not a product.

If you consider mainline a technology and distributions your main users,
what is the use of a stable release every months or two months? No
distribution is going to updates its release that often. Looking at the
Debian kernel packages it took at least a month just to get a single
release ready for distro use. Needless to say, Debian (or any other
distro) is not going to go through that for every release.

We already saw that with 2.0, 2.2 and 2.4 kernels: distributions rarely
used the last mainline release but older released with (a sometimes
huge amount of) patches.

So continueing that thought pattern; why not go for something like 6
month release cycles? That seems to fit with a distro release cycles.

> So I'd suspect that on average, kernel releases are getting more stable. 
> But the big big problem we have is that even though we fixed ten things for
> each one thing we broke, those single breakages tend to be prominent, and
> people get upset.  It's fairly bad PR that Dell Inspiron keyboards don't
> work in 2.6.11, for example...

same for latitude keyboards after a resume I just discovered :(

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
