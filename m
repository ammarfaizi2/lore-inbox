Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131132AbQLUT7M>; Thu, 21 Dec 2000 14:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131342AbQLUT7C>; Thu, 21 Dec 2000 14:59:02 -0500
Received: from www.wen-online.de ([212.223.88.39]:64009 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131132AbQLUT6o>;
	Thu, 21 Dec 2000 14:58:44 -0500
Date: Thu, 21 Dec 2000 20:28:14 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Ian Hastie <ianh@iahastie.clara.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oop in 2.4.0-test12
In-Reply-To: <slrn944fck.hdt.ianh@iahastie.local.net>
Message-ID: <Pine.Linu.4.10.10012211953270.455-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2000, Ian Hastie wrote:

> Looks like page_launder is still causing problems.  I was using
> ReiserFS version 3.6.23.  As far as I remember it was running
> Seti@Home 3.03 and compile qt-2.2.3.  I was able to run ksymoops
> without rebooting.

So, can you (or anyone) reproduce any oops/indication of a kernel
problem without having 'other' stuff in the kernel?  If so, describe
please.. tis not of necessity an indicitation of problems with your
favorite application or driver if it is required to reproduce problem,
but _is_ much easier to diagnose the root if you can provide a formula
for failure [even obscure] which does not include 'foreign' material.

I've not seen a reproducable report yet.. but the reports which I've
seen ~jibe wrt 'there is something fairly odd going on'.  (yes, I've
my share of oddities, and no, I don't have anything solid either;)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
