Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261980AbSJITY0>; Wed, 9 Oct 2002 15:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261986AbSJITY0>; Wed, 9 Oct 2002 15:24:26 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59327 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261980AbSJITYZ>;
	Wed, 9 Oct 2002 15:24:25 -0400
Date: Wed, 9 Oct 2002 12:28:44 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
In-Reply-To: <20021009185203.GK4182@cadcamlab.org>
Message-ID: <Pine.LNX.4.33L2.0210091225100.1001-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Peter Samuelson wrote:

| [Roman Zippel]
| > The problem is that the config syntax will continue to evolve and
| > currently I prefer to keep the library close to the matching config
| > files.
| > I think I can keep the basic structure constant, but new options will be
| > added, so IMO it's more likely that a front end works with a newer
| > library than that a library can understand a newer syntax.
|
| Besides which, I think it is ridiculous that one would have to download
| and install a "kernel configurator" just to build a kernel.  Current
| minimum requirements for compiling the thing are gcc, binutils and GNU
| make.  The kernel can't very well ship a copy of any of those, because
| (a) they're huge and (b) they're useful for many things other than
| building kernels.  Roman's library is neither.

Well, we all find some things more ridiculous than others, but...

The kernel would still have the text-mode configurator.
This only applies to the GUI kernel config.
So you wouldn't have to download the kernel config unless you just
wanted that oh-so-pretty GUI to config it.

[rhetorical question:]
So should it be shipped with a full Qt development environment, e.g.?

| (And no, "modutils" isn't a counterexample - you can build, install and
| run a kernel without it.)

-- 
~Randy
  "In general, avoiding problems is better than solving them."
  -- from "#ifdef Considered Harmful", Spencer & Collyer, USENIX 1992.

