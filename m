Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263235AbRE2HpS>; Tue, 29 May 2001 03:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263232AbRE2Ho7>; Tue, 29 May 2001 03:44:59 -0400
Received: from [207.66.214.139] ([207.66.214.139]:2058 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S263231AbRE2Hou>; Tue, 29 May 2001 03:44:50 -0400
Message-ID: <3B13542A.5DBA3903@chromium.com>
Date: Tue, 29 May 2001 00:47:54 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Leeuw van der, Tim" <tim.leeuwvander@nl.unisys.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac2
In-Reply-To: <DD0DC14935B1D211981A00105A1B28DB033ED2F0@NL-ASD-EXCH-1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Leeuw van der, Tim" wrote:

> But the claim was that 2.4.5-ac2 is faster than 2.4.5 plain, so which
> changes are in 2.4.5-ac2 that would make it faster than 2.4.5 plain? Also, I
> don't know if 2.4.5-ac1 is as fast as 2.4.5-ac2 for Fabio. If not, then it's
> a change in the 2.4.5-ac2 changelog. If it is as fast, it is one of the
> changes in the 2.4.5-ac1 changelog.

2.4.5-ac1 crashed on my machine, vanilla 2.4.5 worked but slower than 2.4.2

2.4.5-ac2 is _a lot_ faster than all the 2.4.4 and of vanilla 2.4.5

please notice that I have a 4G machine, dual proc, and I run a very
memory/IO/CPU intensive test, so your mileage may vary with different
applications.

I have no swapping in my case, it is the filesystem cache that works better in
my case. In the 2.4.4-ac series the machine would slowdown by a good 5-10%
(fluctuating) when the filesystem cache would hit the size of the physical RAM.

I have observed the same behaviour on three different brands (HP, Dell and
Compaq), I don't think that it depends on a specific chipset.

 - Fabio


