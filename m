Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUAYUiK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUAYUiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:38:10 -0500
Received: from hoemail1.lucent.com ([192.11.226.161]:5831 "EHLO
	hoemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265276AbUAYUiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:38:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16404.10496.50601.268391@gargle.gargle.HOWL>
Date: Sun, 25 Jan 2004 15:37:20 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Andi Kleen <ak@muc.de>
Cc: John Stoffel <stoffel@lucent.com>, Valdis.Kletnieks@vt.edu,
       Adrian Bunk <bunk@fs.tum.de>, Fabio Coatti <cova@ferrara.linux.it>,
       Andrew Morton <akpm@osdl.org>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
In-Reply-To: <20040125202557.GD16962@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net>
	<200401251639.56799.cova@ferrara.linux.it>
	<20040125162122.GJ513@fs.tum.de>
	<200401251811.27890.cova@ferrara.linux.it>
	<20040125173048.GL513@fs.tum.de>
	<20040125174837.GB16962@colin2.muc.de>
	<200401251800.i0PI0SmV001246@turing-police.cc.vt.edu>
	<20040125191232.GC16962@colin2.muc.de>
	<16404.9520.764788.21497@gargle.gargle.HOWL>
	<20040125202557.GD16962@colin2.muc.de>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi> On Sun, Jan 25, 2004 at 03:21:04PM -0500, John Stoffel wrote:
>> 
Andi> The latest bk tree (post 2.6.2rc1) has a full solution that
Andi> should cover all architectures.
>> 
>> Can you post your patch please?  I've been running into this too.  I'm
>> compiling 2.6.2-rc1-mm3 right now after having commented out the

Andi> It should be in there already. 

It's not in there, since my Makefile had the -funit-at-a-time stuff,
which I've now commented out.  Still compiling, and waiting to do
areboot to test it out.

>> -funit-at-a-time in Makefile.  I'm running gcc 3.3.3 on Debian with
>> the stable/unstable/testing branches.  

Andi> Did you actually have problems? 

Sure, the darn thing wouldn't boot, it kept Oopsing with the
test_wp_bit oops (that I just posted more details about).

More confirmation as I get it.

John
