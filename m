Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314485AbSEUNA1>; Tue, 21 May 2002 09:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314499AbSEUNA0>; Tue, 21 May 2002 09:00:26 -0400
Received: from host162-6.pool8173.interbusiness.it ([81.73.6.162]:45581 "EHLO
	shiva.lab.novalabs.net") by vger.kernel.org with ESMTP
	id <S314485AbSEUNAZ>; Tue, 21 May 2002 09:00:25 -0400
Message-Id: <5.1.0.14.0.20020521144414.02cedae0@shiva.intra.alphac.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 21 May 2002 15:00:17 +0200
To: linux-kernel@vger.kernel.org
From: Alessandro Morelli <alex@alphac.it>
Subject: RE: PROBLEM: memory corruption with i815 chipset variant
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > Does the ram survive memtest86 overnight with no errors logged if you 
boot memtest86 and just leave it ?
Survived 2hrs (couldn't test it more right now: the laptop is my work 
machine [sigh]).

memtest with agpgart loaded (either static or module) started to report 
errors in MUL, DIV, XOR and others since the first run, never the same 
locations, never the same count. Without agpgart, it produced a joyously 
boring stream of Test nn...passed.

memtest86 loaded from the boot diskette did the same...

However I'll test it more: tonight (here in Italy, it's 15:00) I'll leave 
the thing running...

I need AGP...XFree won't talk to the Radeon without it...

Furthermore, I noted another small problem: first time I tried 
2.4.19-pre8-ac5 I compiled the DRM statically along with agp, later I made 
both of them modules and depmod starts complaining about vmalloc_to_page 
not being defined...

Anyone has experienced same problems with other PCs?

Good work to all,
Alessandro Morelli
AlphaC srl

P.S.: Mr. Cox, I'm impressed: you must be a very busy person and yet you 
answered an out-of-nowhere email in no time flat...Many thanks!

