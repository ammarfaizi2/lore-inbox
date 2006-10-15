Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWJOLFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWJOLFc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 07:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWJOLFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 07:05:32 -0400
Received: from witte.sonytel.be ([80.88.33.193]:37812 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750743AbWJOLFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 07:05:31 -0400
Date: Sun, 15 Oct 2006 12:57:43 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Olaf Hering <olaf@aepfle.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg Banks <gnb@melbourne.sgi.com>,
       Paul Jackson <pj@sgi.com>
Subject: Re: undefined reference to highest_possible_node_id
In-Reply-To: <20061015105106.GV30596@stusta.de>
Message-ID: <Pine.LNX.4.62.0610151257190.31351@pademelon.sonytel.be>
References: <20061015080421.GA17399@aepfle.de> <20061015105106.GV30596@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2006, Adrian Bunk wrote:
> On Sun, Oct 15, 2006 at 10:04:21AM +0200, Olaf Hering wrote:
> > A 2.6.19-rc2 pseries_defconfig build with SMP=n will not link,
> > highest_possible_node_id is undefined because NODES_SHIFT == 4.
> > How can this be fixed properly?
> 
> This known bug in -mm [1] made it into Linus' tree?

Yep, it got introduced in 2.6.19-rc1.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
