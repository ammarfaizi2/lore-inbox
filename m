Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbTAMPX2>; Mon, 13 Jan 2003 10:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbTAMPX2>; Mon, 13 Jan 2003 10:23:28 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:41616 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261286AbTAMPX1>; Mon, 13 Jan 2003 10:23:27 -0500
Date: Mon, 13 Jan 2003 16:32:12 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: why the new config process is a *big* step backwards
Message-ID: <20030113153212.GB12500@louise.pinerecords.com>
References: <Pine.LNX.4.44.0301130743100.25468-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301130743100.25468-100000@dell>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [rpjday@mindspring.com]
> 
>   (apologies to those who are thoroughly sick of this topic, but
> i'm now firmly convinced that i don't much care for the new
> config process, and i'm curious as to whether it's just me.
> Answer: probably.)

Robert,

please study scripts/kconfig/*, not how one particular frontend is.
The new kernel configurator is actually a big improvement over the
traditional stuff we used to have up to 2.4.  Okay, it is a fact that
xconfig is far from great, but that doesn't matter -- the important
thing is Kconfig provides a clean, generic system for the actual kernel
configuration.  As I already pointed out a fortnight ago or so, the
only config frontend likely to stay in linux.tar in the long run is
menuconfig, serving as a reference to userland people who are certain
to come up with heaps of different Kconfig frontends (that is when
2.6 ships I guess).

If you need a nifty graphical frontend right away, I suggest you
go ahead and write the first off-tree xconfig.

-- 
Tomas Szepe <szepe@pinerecords.com>
