Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbSJaBiD>; Wed, 30 Oct 2002 20:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265100AbSJaBiD>; Wed, 30 Oct 2002 20:38:03 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:12432 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265098AbSJaBiC>;
	Wed, 30 Oct 2002 20:38:02 -0500
Date: Wed, 30 Oct 2002 20:44:22 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Aaron Lehmann <aaronl@vitelus.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45
In-Reply-To: <20021031013436.GG23438@vitelus.com>
Message-ID: <Pine.GSO.4.21.0210302041380.13031-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 Oct 2002, Aaron Lehmann wrote:

> On Wed, Oct 30, 2002 at 04:56:29PM -0800, Linus Torvalds wrote:
> > 
> > 
> > Big changes, lots of merges. A number of the merges are fairly
> > substantial too. 
> > 
> > Device mapper (LVM2), crypto/ipsec stuff for networking, epoll and giving
> > the new kernel configurator a chance. Big things.
> 
> Now running 'make oldconfig' or 'make menuconfig' requires a Qt
> installation. I believe that this is a bug because these still work
> fine without Qt when the -k flag is passed to make.

Remove "false" from the rule that spits out annoying shit about absence
of QT (_yes_, I _know_ that I don't have that shite installed, thank
you very much for reminder).

Doesn't solve the annoyance problem, though.

