Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSJFQxF>; Sun, 6 Oct 2002 12:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbSJFQxF>; Sun, 6 Oct 2002 12:53:05 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:1522 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261689AbSJFQxE>; Sun, 6 Oct 2002 12:53:04 -0400
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
	3.0 - (NUMA))
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, Rob Landley <landley@trommello.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021006104219.A27487@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com>
	<200210060130.g961UjY2206214@pimout2-ext.prodigy.net>
	<3D9F9CD5.CEB61219@digeo.com> 
	<20021006104219.A27487@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 18:06:54 +0100
Message-Id: <1033924014.21257.38.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 10:42, Russell King wrote:
> What I'm not saying here is that anything one thing sucks (except maybe
> ARM on a desktop box running Gnome.)  The point I'm trying to make is
> that you can give the kernel as much "interactive" feel as you like, but
> until user space gets It Right (tm), the kernel isn't really going to
> make one blind bit of difference to the "feel" the user experiences.
> 
> I just wish someone would take away all the gnome developers high
> performance machines and give them slow old 486's.  8)

The GNOME stuff is mostly userspace problems not kernel space, and some
of it is tool problems (lack of tools to lay binaries out so they stream
from disk, lack of tools to put all the fixups in the same few pages).
Gnome noticably improved when prelinking in gnu tools began to work

To do a meaningful kernel comparison you need to look at 2.2/2.4/2.5
with the same user space setup. 

As to the 486's. There is optimisation work for gnome and especially
startup going on. Seems its a bit slow on those old legacy sparc64
contraptions ;)

