Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129048AbQJ3MHj>; Mon, 30 Oct 2000 07:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbQJ3MH3>; Mon, 30 Oct 2000 07:07:29 -0500
Received: from deckard.concept-micro.com ([62.161.229.193]:10306 "EHLO
	deckard.concept-micro.com") by vger.kernel.org with ESMTP
	id <S129048AbQJ3MHY>; Mon, 30 Oct 2000 07:07:24 -0500
Message-ID: <XFMail.20001030130943.petchema@concept-micro.com>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <39FCB13E.6267C38D@haque.net>
Date: Mon, 30 Oct 2000 13:09:43 +0200 (CET)
X-Face: #eTSL0BRng*(!i1R^[)oey6`SJHR{3Sf4dc;"=af8%%;d"%\#"Hh0#lYfJBcm28zu3r^/H^
 d6!9/eElH'p0'*,L3jz_UHGw"+[c1~ceJxAr(^+{(}|DTZ"],r[jSnwQz$/K&@MT^?J#p"n[J>^O[\
 "%*lo](u?0p=T:P9g(ta[hH@uvv
Organization: Concept Micro
From: Pierre Etchemaite <petchema@concept-micro.com>
To: "Mohammad A. Haque" <mhaque@haque.net>
Subject: RE: ide/disk perf?
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 30-Oct-2000, Mohammad A. Haque écrivait :
> Could someone who knows ide and drive inside and out (Andre?) please
> take a look at these figures? Am I forgetting to do something (or doing
> something I'm not suposed to) to get the best numbers? I thought I'd be
> able to get more than ~4MB/sec off the HPT366 and a UDMA66 drive.

It could be unrelated, but I had problems several times with Maxtor drives
recently; Their performances are usually high (some models give >20 Mb/s
both reads and writes), but under some conditions that I couldn't narrow down
yet, the read throughput is stuck to the floor (a few megabytes/sec) until
next reboot. The write performance is always ok.

I don't think it's a chipset problem, with a box filled with several Maxtor
drives and I observe the problem with some disk and not others at the same time.

I don't think it's a Linux problem either, since it can be observed with
Windows benchmarking tools too.


As a side note, I usually get better results tweaking disks using kernel
compiling options ("default to DMA", "autotune chipset", ...) than using hdparm
-d1 and friends, give it a try.


-- 
Linux blade.workgroup 2.4.0-test10 #1 Sat Oct 28 18:00:09 CEST 2000 i686 unknown
  1:09pm  up 1 day, 19:01,  2 users,  load average: 1.04, 1.08, 1.09

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
