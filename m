Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUAZOPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 09:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbUAZOPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 09:15:43 -0500
Received: from hoemail2.lucent.com ([192.11.226.163]:4803 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263513AbUAZOPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 09:15:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16405.8396.359717.70413@gargle.gargle.HOWL>
Date: Mon, 26 Jan 2004 09:14:36 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Andi Kleen <ak@muc.de>
Cc: John Stoffel <stoffel@lucent.com>, Adrian Bunk <bunk@fs.tum.de>,
       Valdis.Kletnieks@vt.edu, Fabio Coatti <cova@ferrara.linux.it>,
       Andrew Morton <akpm@osdl.org>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
In-Reply-To: <20040126050431.GB6519@colin2.muc.de>
References: <20040125174837.GB16962@colin2.muc.de>
	<200401251800.i0PI0SmV001246@turing-police.cc.vt.edu>
	<20040125191232.GC16962@colin2.muc.de>
	<16404.9520.764788.21497@gargle.gargle.HOWL>
	<20040125202557.GD16962@colin2.muc.de>
	<16404.10496.50601.268391@gargle.gargle.HOWL>
	<20040125214920.GP513@fs.tum.de>
	<16404.20183.783477.596431@gargle.gargle.HOWL>
	<20040125234756.GF28576@colin2.muc.de>
	<16404.34836.753760.759367@gargle.gargle.HOWL>
	<20040126050431.GB6519@colin2.muc.de>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> On node 0 totalpages: 196606
>> DMA zone: 4096 pages, LIFO batch:1
>> Normal zone: 192510 pages, LIFO batch:16
>> HighMem zone: 0 pages, LIFO batch:1

Andi> Ok, it didn't oops. Just hung early. Probably needs some printks
Andi> to track it down.

Andi> And the problem really goes away when you disable -funit-at-a-time ?

This was from both 2.6.2-rc1 and 2.6.2-rc2, and since the later
doesn't have the -funit-at-time declaration in the Makefile, I don't
think that's the problem.

My gcc version is:

    > gcc --version
    gcc.real (GCC) 3.3.3 20040110 (prerelease) (Debian)


John
