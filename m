Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTLZFKJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 00:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTLZFKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 00:10:09 -0500
Received: from [64.65.177.98] ([64.65.177.98]:11766 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S264487AbTLZFKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 00:10:03 -0500
Subject: Re: 2.6.0 problems
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: dan@eglifamily.dnsalias.net
Cc: Eric <eric@cisu.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312260106510.1888-100000@eglifamily.dnsalias.net>
References: <Pine.LNX.4.44.0312260106510.1888-100000@eglifamily.dnsalias.net>
Content-Type: text/plain
Message-Id: <1072415388.27022.214.camel@menion.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 25 Dec 2003 21:09:48 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-25 at 17:07, dan@eglifamily.dnsalias.net wrote:
> On Thu, 25 Dec 2003, Eric wrote:
> 
> > On Thursday 25 December 2003 02:57 pm, dan@eglifamily.dnsalias.net wrote:
> > > I grabbed the 2.6.0 code yesterday. But when I tried to compile a
> > > modular kernel, I got a *LOT* of unresolved symbols in the modules. I'm
> > > attaching the stderr output from depmod's run of make modules_install.
> > 	I had this problem with a RH9 install. Instead of modutils, upgrade the the 
> > latest module-init-tools from ftp://kernel.org.
> > 	The problem is that most of the module loading code has been moved from 
> > userspace to kernel code to make module loading more portable. Be sure to 
> > follow the upgrade instructions carefully. If done correctly it will keep 
> > your old modutils in case you load a 2.4.x kernel and will default to the new 
> > module-init-tools for 2.6.x kernels.
> 
> I'll try that, thanks!
> 
> Any ideas on the blank screen issue?
> 
> --- Dan


I took module-init-tools out of Redhat Severn beta, and I upgraded init
scripts, ethtool, and module-init-tools at the same time, it worked vary
nicely.

-- 
VB programmers ask why no one takes them seriously, 
it's somewhat akin to a McDonalds manager asking employees 
why they don't take their 'career' seriously.

