Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbTJSHWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 03:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTJSHWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 03:22:25 -0400
Received: from d216-232-206-119.bchsia.telus.net ([216.232.206.119]:4612 "EHLO
	cyclops.implode.net") by vger.kernel.org with ESMTP id S262002AbTJSHWX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 03:22:23 -0400
Date: Sun, 19 Oct 2003 00:22:18 -0700
From: John Wong <kernel@implode.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine on 2.4.23-pre6 Too much work at interrupt, status=0x00001000. (fwd)
Message-ID: <20031019072218.GA14146@gambit.implode.net>
References: <Pine.LNX.4.44.0310171852330.12627-100000@logos.cnet> <3F90687E.8030601@pobox.com> <20031019060953.GA1663@gambit.implode.net> <20031019071012.GA13898@gambit.implode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031019071012.GA13898@gambit.implode.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reposting to the LKML as my previous post had a technical difficulty.

John

On Sun, Oct 19, 2003 at 12:10:12AM -0700, John Wong wrote:
> I received the same problem with 2.4.23-pre2.  Just to amuse myself, I
> booted up 2.4.22 and the problem of Too much work still occurs.  
> 
> John
> 
> On Sat, Oct 18, 2003 at 11:09:53PM -0700, John Wong wrote:
> > Hi,
> > 
> > I took a slightly different route, and updated the kernel to 2.4.23-pre7
> > and disabled ACPI.  The problem did reoccur, so this would rule out
> > ACPI.  I will downgrade the kernel to pre2 now.
> > 
> > Oct 18 21:46:58 cyclops kernel: eth0: Too much work at interrupt,
> > status=0x00001000.
> > 
> > John
> > 
> > On Fri, Oct 17, 2003 at 06:09:02PM -0400, Jeff Garzik wrote:
> > > >Date: Thu, 16 Oct 2003 12:27:17 -0700
> > > >From: John Wong <kernel@implode.net>
> > > >To: linux-kernel@vger.kernel.org
> > > >Subject: via-rhine on 2.4.23-pre6 Too much work at interrupt,
> > > >     status=0x00001000.
> > > >
> > > >The system used to run 2.4.22 and did not have this too much work
> > > >problem.  There were some other hardware changes.  The system used to be
> > > >a Pentium 100 on a Triton 430FX chipset Intel Advanced/EV board.  Now it 
> > > >is a K6 2 - 500 on a Via Apollo MVP3 chipset on FIC VA-503+ board.
> > > >The NIC stayed the same.  The kernel was recompiled and ACPI was
> > > >enabled.
> > > >
> > > >I noticed in 2.4.23-pre2 -> pre3
> > > >	 [netdrvr] sync with 2.5: epic100, fealnx, via-rhine, winbond-840
> > > 
> > > 
> > > This cset contains no functional via-rhine changes...  First thing to do 
> > > would be try to 2.4.23-pre2.  But my main suspect would be ACPI.
> > > 
> > > 	Jeff
> > > 
> > > 
> > > 
