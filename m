Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVCERou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVCERou (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 12:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVCERlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 12:41:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:8162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261688AbVCERjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 12:39:48 -0500
Date: Sat, 5 Mar 2005 09:40:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
In-Reply-To: <4229EA0A.8010608@pobox.com>
Message-ID: <Pine.LNX.4.58.0503050930430.2304@ppc970.osdl.org>
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org>
 <20050304205842.GA32232@kroah.com> <20050304131537.7039ca10.akpm@osdl.org>
 <Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org> <20050304135933.3a325efc.akpm@osdl.org>
 <20050304220518.GC1201@kroah.com> <20050305095139.A26541@flint.arm.linux.org.uk>
 <4229EA0A.8010608@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Mar 2005, Jeff Garzik wrote:
> 
> Yup, BK could definitely handle that...

However, it's also true that the thing BK is _worst_ at is cherry-picking 
things, and having a collection of stuff where somebody may end up vetoing 
one patch and saying "remove that one".

So it's entirely possible that the proper tool to use for the first level 
is not BK at all, but the evolved patch-scripts that Andrew uses, in other 
words:

	http://savannah.nongnu.org/projects/quilt

may well be a much better thing to use.

I love BK, but what BK does well is merging and maintaining trees full of 
good stuff. What BK sucks at is experimental stuff where you don't know 
whether something should be eventually used or not.

			Linus
