Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUH1UhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUH1UhR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbUH1UfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:35:19 -0400
Received: from the-village.bc.nu ([81.2.110.252]:10368 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268008AbUH1USM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:18:12 -0400
Subject: Re: DTrace-like analysis possible with future Linux kernels?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Milkowski <milek@rudy.mif.pg.gda.pl>
Cc: Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Julien Oster <usenet-20040502@usenet.frodoid.org>,
       Miles Lane <miles.lane@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60L.0408232107270.13955@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net>
	 <87hdqyogp4.fsf@killer.ninja.frodoid.org>
	 <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
	 <1093174557.24319.55.camel@localhost.localdomain>
	 <Pine.LNX.4.60L.0408232107270.13955@rudy.mif.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093354658.2810.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 28 Aug 2004 20:16:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-23 at 20:48, Robert Milkowski wrote:
> Solaris runs on x86 platform, and runs quite well.
> And guess what - DTrace runs on x86 like a charm.

Larger x86 boxes. I can't seem to find PDA's with Solaris or phones
with Solaris or $70 wireless routers with Solaris.

> I must admit I don't know OProfile.
> But can you profile already running application without interuption

Yes

> What about getting structure contents, function arguments and returns, 
> etc... all on the fly.

ptrace. Actually there are folks who want to take ptrace a bit further
for some things - at least one vendor posted some proposals which when
recast into ptrace extensions look good.

> I think you missed the point.

Nope

> Sure, you can make your own module on Linux, load it and trace whatever 
> you want. But:

Why do that, why not use the existing functionality that the kernel
provides built on the stuff Intel AMD and friends stuck in the CPU. I'm
not claiming our debugging tools are as good as dtrace but most of it
(especially with kprobes patches installed) is essentially a UI design
issue.

Alan

