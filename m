Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTIOIdx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 04:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbTIOIdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 04:33:53 -0400
Received: from math.ut.ee ([193.40.5.125]:20451 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261292AbTIOIdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 04:33:51 -0400
Date: Mon, 15 Sep 2003 11:33:47 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
In-Reply-To: <Pine.LNX.4.44.0309141117030.15181-100000@deadlock.et.tudelft.nl>
Message-ID: <Pine.GSO.4.44.0309151131200.10040-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the default video mode on your sparc? Could the value that is
> read be CRTC_PIX_WIDTH_4BPP or CRTC_PIX_WIDTH_16BPP? (Atyfb does only
> support 8, 15, 24 and 32 bpp)

No idea. But it has been the same all the time and it worked before the
lcd patch.

> > Here I get stuck - maybe pll_regs points to a wrong value...
>
> Quite likely. I'm going to send you a few modifications, we'll see if they
> do something.

Your patch that uses unsigned longs in mach64_ct.c fixed the oops but
atyfb now tells only
atyfb: Unknown mach64 0x000 rev 0x000
and disables itself.

-- 
Meelis Roos (mroos@linux.ee)

