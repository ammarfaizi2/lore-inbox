Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317563AbSFMJZ4>; Thu, 13 Jun 2002 05:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317564AbSFMJZz>; Thu, 13 Jun 2002 05:25:55 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:3279 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S317563AbSFMJZx>; Thu, 13 Jun 2002 05:25:53 -0400
Date: Thu, 13 Jun 2002 17:25:44 +0800 (PHT)
From: Federico Sevilla III <jijo@free.net.ph>
X-X-Sender: jijo@kalabaw
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rlimits and non overcommit
In-Reply-To: <2660.1023948685@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0206131723060.3677-100000@kalabaw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2002 at 16:11, Keith Owens wrote:
> On Thu, 13 Jun 2002 13:57:33 +0800 (PHT),
> Federico Sevilla III <jijo@free.net.ph> wrote:
> >On Thu, 13 Jun 2002 at 06:39, Alan Cox wrote:
> >> > check to prevent such large sizes from crashing X and/or the X Font
> >> > Server, I'm alarmed by (1) the way the X font server allows itself to
> >> > be crashed like this, and (2) the way the entire Linux kernel seems to
> >> > have been unable to handle the situation. While having a central
> >> > company or
> >>
> >> So turn on the features to conrol it. Set rlimits on the xfs server and
> >> enable non overcommit (-ac kernel)
> >
> >I am using SGI's XFS, and I think they follow Marcelo's kernels for the
>
> SGI's XFS != xfs server.  SGI XFS == journalling filesystem.
> xfs server == font server for the X windowing system.

Argh. And we get hit by similarly-named projects. :(

To clarify: I wanted to know if there were plans of getting non overcommit
from the AC tree into Marcelo's mainline 2.4 tree, because I use SGI's XFS
(journalling filesystem), and thus use the -xfs kernel tree, which follows
-marcelo and not -ac.

Apologies.

 --> Jijo

-- 
Federico Sevilla III   :  <http://jijo.free.net.ph/>
Network Administrator  :  The Leather Collection, Inc.
GnuPG Key ID           :  0x93B746BE

