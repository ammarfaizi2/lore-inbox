Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261641AbSJ2IQV>; Tue, 29 Oct 2002 03:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbSJ2IQU>; Tue, 29 Oct 2002 03:16:20 -0500
Received: from denise.shiny.it ([194.20.232.1]:10391 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S261641AbSJ2IQU>;
	Tue, 29 Oct 2002 03:16:20 -0500
Message-ID: <XFMail.20021029092233.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3DBE2EBE.DC860105@digeo.com>
Date: Tue, 29 Oct 2002 09:22:33 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.44-mm6 contest results
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>, Con Kolivas <conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29-Oct-2002 Andrew Morton wrote:
> Con Kolivas wrote:
>> 2.5.44-mm6 [3]          226.9   33      50      2       3.18
>>
>> Mem load has dropped off again
>
> Well that's one interpretation.  The other is "goody, that pesky
> kernel compile isn't slowing down my important memory-intensive
> whateveritis so much".  It's a tradeoff.

This test should display the speed of the memory hog, kernel
compile and also how much disk i/o occurred to be really
meaningful. But IMO disk i/o is the one that slows things
down, so we should try to keep it as low as possible (and this
test show nothing about it).


Bye.

