Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUG3Xji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUG3Xji (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 19:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267872AbUG3Xji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 19:39:38 -0400
Received: from the-village.bc.nu ([81.2.110.252]:32935 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264531AbUG3Xja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 19:39:30 -0400
Subject: Re: Exposing ROM's though sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jon Smirl <jonsmirl@yahoo.com>,
       Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200407301326.48094.jbarnes@engr.sgi.com>
References: <1091207136.2762.181.camel@rohan.arnor.net>
	 <20040730172433.2312.qmail@web14924.mail.yahoo.com>
	 <20040730191448.GA2461@ucw.cz>  <200407301326.48094.jbarnes@engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091226981.5066.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 30 Jul 2004 23:36:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-07-30 at 21:26, Jesse Barnes wrote:
> On Friday, July 30, 2004 12:14 pm, Vojtech Pavlik wrote:
> > I'm starting to think that using emu86 always (independent on the
> > architecture) would be best. It's not like the execution speed is the
> > limit with video init, and it'll allow to find more bugs in emu86 when
> > it's used on i386 as well. It'll be needed for x86-64 (AMD64 and intel
> > EM64T) anyway.
> 
> Yeah, I was thinking the same thing, but emu86 needs some fixes to work on an 
> x86 host apparently...

emu86 is rather buggy. It can't boot C&T BIOSes for example. qemu might
be a better engine for this anyway in truth.

