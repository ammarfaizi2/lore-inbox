Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbUAZFHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 00:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUAZFHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 00:07:39 -0500
Received: from colin2.muc.de ([193.149.48.15]:3332 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265514AbUAZFGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 00:06:25 -0500
Date: 26 Jan 2004 06:04:31 +0100
Date: Mon, 26 Jan 2004 06:04:31 +0100
From: Andi Kleen <ak@muc.de>
To: John Stoffel <stoffel@lucent.com>
Cc: Andi Kleen <ak@muc.de>, Adrian Bunk <bunk@fs.tum.de>,
       Valdis.Kletnieks@vt.edu, Fabio Coatti <cova@ferrara.linux.it>,
       Andrew Morton <akpm@osdl.org>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040126050431.GB6519@colin2.muc.de>
References: <20040125174837.GB16962@colin2.muc.de> <200401251800.i0PI0SmV001246@turing-police.cc.vt.edu> <20040125191232.GC16962@colin2.muc.de> <16404.9520.764788.21497@gargle.gargle.HOWL> <20040125202557.GD16962@colin2.muc.de> <16404.10496.50601.268391@gargle.gargle.HOWL> <20040125214920.GP513@fs.tum.de> <16404.20183.783477.596431@gargle.gargle.HOWL> <20040125234756.GF28576@colin2.muc.de> <16404.34836.753760.759367@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16404.34836.753760.759367@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     On node 0 totalpages: 196606
>       DMA zone: 4096 pages, LIFO batch:1
>       Normal zone: 192510 pages, LIFO batch:16
>       HighMem zone: 0 pages, LIFO batch:1

Ok, it didn't oops. Just hung early. Probably needs some printks
to track it down.

And the problem really goes away when you disable -funit-at-a-time ?

-Andi
