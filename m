Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288402AbSA0T1C>; Sun, 27 Jan 2002 14:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288414AbSA0T0w>; Sun, 27 Jan 2002 14:26:52 -0500
Received: from mx04.nexgo.de ([151.189.8.80]:4619 "EHLO mx04.nexgo.de")
	by vger.kernel.org with ESMTP id <S288402AbSA0T0n>;
	Sun, 27 Jan 2002 14:26:43 -0500
Message-ID: <3C54546C.0@arcor.de>
Date: Sun, 27 Jan 2002 20:26:36 +0100
From: Hartmut Holz <hartmut.holz@arcor.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020116
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Uptime again?
In-Reply-To: <Pine.LNX.4.33L.0201261935330.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> The fact that lavrec crashes the machine while Xawtv works
> suggests a device driver may be corrupting memory somewhere.
> 

I got a debug patch from Manfred Spraul to debug slab.c. With this patch
the machine ran for about 3 hours. No problem. I looked into slab.c and had an
idea. What about just one CPU. So I built a new Kernel with just one CPU.
Result: 1 CPU 1 Minute - 2 CPU 20 Minutes. I aspected a different result.
In my opinion the whole thing has something to do with slab, SMP and threads.

The machine (450Mhz PII, 448 MB, Intel L440GX Mainboard, Adaptec) it self is solid.
It has run every 2.3.x and  2.4.x Kernel, Oracle and Sybase (only development).
No problem.
.

Regards

Hartmut




