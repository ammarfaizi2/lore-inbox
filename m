Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbVCDMGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbVCDMGY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVCDLyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:54:37 -0500
Received: from mail.dif.dk ([193.138.115.101]:34238 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262907AbVCDLbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:31:10 -0500
Date: Fri, 4 Mar 2005 12:32:07 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <42268037.3040300@osdl.org>
Message-ID: <Pine.LNX.4.62.0503041212580.2794@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
 <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com>
 <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com>
 <42268037.3040300@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Randy.Dunlap wrote:
>
> Maybe I don't understand?  Is someone expecting distro
> quality/stability from kernel.org kernels?
> I don't, but maybe I'm one of those minorities.
> 
I certainly do, and I think many others do as well.

My assumptions/expectations on vanilla kernels has changed a bit over 
time, and I don't expect as much from them these days as I once did.

I used to expect/assume (and this was back when I had never touched a 
single line of kernel code nor read a single post on lkml), that 1) the 
vanilla kernel was the ones with all the latest bugfixes and features 2) 
the latest stable vanilla kernel had gone through extensive testing 
(manual and automated) to make sure there were no regressions compared to 
the previous release 3) I could always go from <stable_series>.X to 
<stable_series>.X+1 without any features having disappeared 4) that a new 
vanilla kernel would never be released if there were still known bugs in 
it (even if those bugs were not regressions).

I've become wiser since then, and I'm more aware of the level of testing 
actually done, so I expect to be hit by bugs/regressions in vanilla 
kernels once in a while. But I still expect a very high degree of 
stability/quality from stable series vanilla kernels in general..

I run vanilla kernels on all my boxes, workstations and servers, since I 
don't really trust vendor kernels. I don't want to start relying on 
features only available in a single vendors patched kernel so that I will 
have trouble if I switch vendor (or want to get some new feature that's in 
vanilla but has not entered the vendors kernel yet). I've also had bad 
experiences in the past with patched vendor kernels being more unstable on 
my boxes than the vanilla kernels.. and then there's the testing issue, if 
everyone ran vendor kernels then who'd be testing vanilla?


-- 
Jesper Juhl


