Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267266AbSK3QKK>; Sat, 30 Nov 2002 11:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbSK3QKK>; Sat, 30 Nov 2002 11:10:10 -0500
Received: from [195.223.140.107] ([195.223.140.107]:429 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267266AbSK3QKI>;
	Sat, 30 Nov 2002 11:10:08 -0500
Date: Sat, 30 Nov 2002 17:17:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.4.20-rc2-aa1 with contest
Message-ID: <20021130161724.GD28164@dualathlon.random>
References: <200211230929.31413.conman@kolivas.net> <20021124162845.GC12212@dualathlon.random> <200211251744.35509.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211251744.35509.conman@kolivas.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 05:44:30PM +1100, Con Kolivas wrote:
> finishes testing in that load. To reproduce it yourself, run mem_load then do 
> a kernel compile make -j(4xnum_cpus).  If that doesnt do it I'm not sure how 

JFYI: can't reproduce it here with kernel compile and mem_load in
parallel. Did you compile in AGP? there's apparently some known issue
with AGP/DRI.

Andrea
