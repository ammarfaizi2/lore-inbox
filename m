Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbSKNRd5>; Thu, 14 Nov 2002 12:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbSKNRd5>; Thu, 14 Nov 2002 12:33:57 -0500
Received: from ns.suse.de ([213.95.15.193]:46602 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265065AbSKNRd4>;
	Thu, 14 Nov 2002 12:33:56 -0500
Date: Thu, 14 Nov 2002 18:40:49 +0100
From: Andi Kleen <ak@suse.de>
To: John Alvord <jalvo@mbay.net>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: module mess in -CURRENT
Message-ID: <20021114184049.A28183@wotan.suse.de>
References: <p731y5owj0x.fsf@oldwotan.suse.de> <Pine.LNX.4.20.0211140929080.28420-100000@otter.mbay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.20.0211140929080.28420-100000@otter.mbay.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Owens' kbuild-2.5 handled it a different way and didn't need exact
> timings. That is especially important since nanosecond time accuracy is

You may not believe it, but there are projects other than the kernel
that do use make too.

> impossible if you are handling a collection of machines doing the
> work. NTP is accurate, but not that accurate.

The patch does not actually implement nanosecond resolution, but
jiffies resolution (1ms on 2.5), which is easily reachable with NTP.

-Andi
