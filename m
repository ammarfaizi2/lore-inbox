Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265189AbSJaEMw>; Wed, 30 Oct 2002 23:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265193AbSJaEMw>; Wed, 30 Oct 2002 23:12:52 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:29713 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S265189AbSJaEMv>; Wed, 30 Oct 2002 23:12:51 -0500
Date: Wed, 30 Oct 2002 23:20:42 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: linux-kernel@vger.kernel.org
cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210302302360.8463-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm kind of new here, but I'll present my case in hope that someone
listens to me.



On Wed, 30 Oct 2002, Linus Torvalds wrote:

> On Thu, 31 Oct 2002, Rusty Russell wrote:
>
> > Crash Dumping (LKCD)
>
> This is definitely a vendor-driven thing. I don't believe it has any
> relevance unless vendors actively support it.

This is something that we're just starting to use in my department in
Purdue - we work with clustering, and LKCD will let us determine why our
nodes decide to kernel panic since it's generally not worthwhile to
connect a head to each machine.

I see LKCD as having a big impact by allowing kernels to be debugged after
they have panic'd (and thus don't send out a message to syslog).  It can
especially be usful in compute farms, or other scenerios where it's
difficut or cost prohibitive to connect a console (or console server) to
each individual machine.

> > EVMS
>
> Not for the feature freeze, there are some noises that imply that SuSE may
> push it in their kernels.

I think that the integration between RAID and LVM is a good thing, and
EVMS's 'plug-in module' architecture will help tremendously to bring
interoperation with other systems' volume management subsystems.
Specifically, the interoperation with IBM's JFS LVM and MS's LVM will be
helpful for people trying to migrate their servers over from those OS's to
GNU/Linux.

-- Pat

Purdue University ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu


