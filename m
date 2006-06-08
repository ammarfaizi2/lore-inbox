Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWFHPls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWFHPls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 11:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWFHPls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 11:41:48 -0400
Received: from xenotime.net ([66.160.160.81]:18149 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964881AbWFHPlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 11:41:47 -0400
Date: Thu, 8 Jun 2006 08:44:33 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: jdike@addtoit.com, akpm@osdl.org, jamagallon@ono.com,
       linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH] ignore smp_locks section warnings from init/exit code
Message-Id: <20060608084433.3b612916.rdunlap@xenotime.net>
In-Reply-To: <20060607212958.5270a860.rdunlap@xenotime.net>
References: <20060607104724.c5d3d730.akpm@osdl.org>
	<20060608003153.36f59e6a@werewolf.auna.net>
	<20060607154054.cf4f2512.akpm@osdl.org>
	<20060607162326.3d2cc76b.rdunlap@xenotime.net>
	<20060608021149.GA5567@ccure.user-mode-linux.org>
	<20060607193225.989add4c.rdunlap@xenotime.net>
	<20060608042109.GA6337@ccure.user-mode-linux.org>
	<20060607212958.5270a860.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 21:29:58 -0700 Randy.Dunlap wrote:

> On Thu, 8 Jun 2006 00:21:09 -0400 Jeff Dike wrote:
> 
> > On Wed, Jun 07, 2006 at 07:32:25PM -0700, Randy.Dunlap wrote:
> > > > make ARCH=um allmodconfig
> > > /var/linsrc/linux-2617-rc6mm1/arch/um/Makefile:113: *** missing separator.  Stop.
> > > 
> > > is that known/fixed?
> > 
> > No.  rc6-mm1 builds fine here.  I just checked with a fresh tree.
> > 
> > Are you sure you have a clean tree?
> 
> Yes, must be some toolchain problem.
> I'll look at it more, but it's somewhat low priority for me.

FWIW, I get this same error on 2 different systems,
x86_64 + distro1 vs. i386 + distro2.  Odd.

---
~Randy
