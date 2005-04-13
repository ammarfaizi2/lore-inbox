Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVDMOlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVDMOlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVDMOlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:41:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:3495 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261267AbVDMOll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:41:41 -0400
Date: Wed, 13 Apr 2005 07:43:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, David Eger <eger@havoc.gtf.org>,
       Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
In-Reply-To: <20050413103052.C1798@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0504130739400.4501@ppc970.osdl.org>
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050412040519.GA17917@havoc.gtf.org>
 <20050412081613.GA18545@pasky.ji.cz> <20050412204429.GA24910@havoc.gtf.org>
 <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org> <20050412234005.GJ1521@opteron.random>
 <Pine.LNX.4.58.0504121644430.4501@ppc970.osdl.org> <20050413103052.C1798@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Apr 2005, Russell King wrote:
> 
> And my entire 2.6.12-rc2 BK tree, unchecked out, is about 220MB, which
> is more dense than CVS.
> 
> BK is also a lot better than CVS.  So _your_ point is?

Hey, anybody who wants to argue that BK is getter than GIT won't be 
getting any counter-arguments from me.

The fact is, I have constraints. Like needing something to work within a
few days. If somebody comes up with a ultra-fast, replicatable, space
efficient SCM in three days, I'm all over it. 

In the meantime, I'd suggest people who worry about network bandwidth try 
to work out a synchronization protocol that allows you to send "diff 
updates" between git repositories. The git model doesn't preclude looking 
at the objects and sending diffs instead (and re-creating the objects on 
the other side). But my time-constraints _do_.

		Linus
