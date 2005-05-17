Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVEQQHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVEQQHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVEQQFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:05:33 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:37386 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261755AbVEQP7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:59:25 -0400
Date: Tue, 17 May 2005 16:59:29 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup
 and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI)
In-Reply-To: <Pine.LNX.4.58.0505170844550.18337@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61L.0505171656300.17529@blysk.ds.pg.gda.pl>
References: <42822B5F.8040901@sw.ru> <768860000.1116282855@flay>
 <42899797.2090702@sw.ru> <Pine.LNX.4.58.0505170844550.18337@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Linus Torvalds wrote:

> > BTW, why NMI watchdog is disabled by default? We constantly making it on 
> > by default in our kernels and had no problems with it.
> > I send a patch attached which tunes NMI watchdog by config option...
> 
> I really don't want NMI watchdogs enabled by default. It's historically 
> been _very_ fragile on some systems. Whether that has been due to harware 
> or sw bugs, I dunno, but it's definitely been problematic.

 Mostly or perhaps even exclusively due to BIOS bugs -- you know, that 
piece of hidden firmware that runs in the SMM under our feet and fiddles 
randomly with hardware we can do nothing about.

  Maciej
