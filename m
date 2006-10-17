Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422753AbWJQILr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422753AbWJQILr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 04:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422776AbWJQILr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 04:11:47 -0400
Received: from witte.sonytel.be ([80.88.33.193]:15005 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1422753AbWJQILq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 04:11:46 -0400
Date: Tue, 17 Oct 2006 10:11:36 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Mark Gross <mark.gross@intel.com>
Subject: Re: [PATCH] CONFIG_TELCLOCK depends on X86
In-Reply-To: <20061016165426.d32352b4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0610171010030.15288@pademelon.sonytel.be>
References: <Pine.LNX.4.64.0610161957520.10901@anakin> <20061016165426.d32352b4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Andrew Morton wrote:
> On Mon, 16 Oct 2006 19:59:43 +0200 (CEST)
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > The telecom clock driver for MPBL0010 ATCA SBC depends on X86
> > 
> 
> But it compiles on other architectures (doesn't it?)
> 
> And perhaps sometime the hardware will be available on other architectures.
> 
> And there's benefit in being able to compile drivers on other architectures
> - sometimes it will catch bugs.
> 
> IOW: what is the reason for making this change?

It does ISA I/O accesses and failed to build for most m68k platforms.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
