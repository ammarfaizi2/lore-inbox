Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265280AbUAYVt5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 16:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUAYVt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 16:49:57 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53999 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265280AbUAYVt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 16:49:29 -0500
Date: Sun, 25 Jan 2004 22:49:20 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: John Stoffel <stoffel@lucent.com>
Cc: Andi Kleen <ak@muc.de>, Valdis.Kletnieks@vt.edu,
       Fabio Coatti <cova@ferrara.linux.it>, Andrew Morton <akpm@osdl.org>,
       Eric <eric@cisu.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040125214920.GP513@fs.tum.de>
References: <200401251639.56799.cova@ferrara.linux.it> <20040125162122.GJ513@fs.tum.de> <200401251811.27890.cova@ferrara.linux.it> <20040125173048.GL513@fs.tum.de> <20040125174837.GB16962@colin2.muc.de> <200401251800.i0PI0SmV001246@turing-police.cc.vt.edu> <20040125191232.GC16962@colin2.muc.de> <16404.9520.764788.21497@gargle.gargle.HOWL> <20040125202557.GD16962@colin2.muc.de> <16404.10496.50601.268391@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16404.10496.50601.268391@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 03:37:20PM -0500, John Stoffel wrote:
>...
> >> -funit-at-a-time in Makefile.  I'm running gcc 3.3.3 on Debian with
> >> the stable/unstable/testing branches.  
> 
> Andi> Did you actually have problems? 
> 
> Sure, the darn thing wouldn't boot, it kept Oopsing with the
> test_wp_bit oops (that I just posted more details about).
> 
> More confirmation as I get it.

I'd say that's a different issue:
The gcc 3.3 in debian unstable doesn't know about -funit-at-a-time, and 
it should therefore not be affected by this problem.

> John

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

