Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262485AbSJISrq>; Wed, 9 Oct 2002 14:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262487AbSJISrp>; Wed, 9 Oct 2002 14:47:45 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:44673 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S262485AbSJISrn>; Wed, 9 Oct 2002 14:47:43 -0400
Date: Wed, 9 Oct 2002 13:52:03 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
Message-ID: <20021009185203.GK4182@cadcamlab.org>
References: <20021009174038.A960@infradead.org> <Pine.LNX.4.44.0210091859030.8911-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210091859030.8911-100000@serv>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Roman Zippel]
> The problem is that the config syntax will continue to evolve and
> currently I prefer to keep the library close to the matching config
> files.
> I think I can keep the basic structure constant, but new options will be
> added, so IMO it's more likely that a front end works with a newer
> library than that a library can understand a newer syntax.

Besides which, I think it is ridiculous that one would have to download
and install a "kernel configurator" just to build a kernel.  Current
minimum requirements for compiling the thing are gcc, binutils and GNU
make.  The kernel can't very well ship a copy of any of those, because
(a) they're huge and (b) they're useful for many things other than
building kernels.  Roman's library is neither.

(And no, "modutils" isn't a counterexample - you can build, install and
run a kernel without it.)

Peter
