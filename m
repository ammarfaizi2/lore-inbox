Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUCAWXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUCAWVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:21:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:14273 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261456AbUCAWVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:21:08 -0500
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Frank <mhf@linuxmail.org>
Cc: Micha Feigin <michf@post.tau.ac.il>,
       Software suspend <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <opr36ojxik4evsfm@smtp.pacific.net.th>
References: <1ulUA-33w-3@gated-at.bofh.it>
	 <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz>
	 <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th>
	 <20040229213302.GA23719@luna.mooo.com>
	 <opr35wvvrw4evsfm@smtp.pacific.net.th> <1078139361.21578.65.camel@gaston>
	 <opr36ljbsu4evsfm@smtp.pacific.net.th> <1078141191.28288.83.camel@gaston>
	 <opr36ojxik4evsfm@smtp.pacific.net.th>
Content-Type: text/plain
Message-Id: <1078179022.21573.136.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 09:10:22 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Appreciated, suspending a driver like sending XOFF to a tty is ideal,
> but not neccessary for _most_ drivers (software suspend) purpose.
> 
> Wrt IDE, in practice all processes get frozen well before
> suspending drivers. Tested and no issues were ever reported with 2.4.

It is still fragile. I have seen IDE requests slipping in anyway.

But IDE isn't a problem, I wrote a working PM implementation for
IDE in 2.6. 

> > Moving to the new model is easy. I don't see why we should have had
> > such a "compatibility" path on a major kernel version, that makes
> > no sense, just help fixing the drivers that need more fixing instead.
> 
> What for write new drivers for (fast obsoleting) hardware?.

Ok, you are at troll, no need to argue more.



