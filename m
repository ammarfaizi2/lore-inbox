Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbRFLP6g>; Tue, 12 Jun 2001 11:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262058AbRFLP60>; Tue, 12 Jun 2001 11:58:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64265 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262084AbRFLP6Q>; Tue, 12 Jun 2001 11:58:16 -0400
Subject: Re: VIA KT133A crash *post* 2.4.3-ac6
To: rachel@linuxgrrls.org (Rachel Greenham)
Date: Tue, 12 Jun 2001 16:56:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B2606CF.10003@linuxgrrls.org> from "Rachel Greenham" at Jun 12, 2001 01:10:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159qX2-0001WC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With DMA (UDMA Mode 5) enabled, my machine crashes on kernel versions 
> from 2.4.3-ac7 onwards up to 2.4.5 right up to 2.4.5-ac13. 2.4.3 vanilla 
> and 2.4.3-ac6 are completely stable. -ac7 of course is when a load of 
> VIA fixes were done. :-}

Unfortunately there isnt a great deal I can do but say 'talk to VIA'. 

> With DMA (any setting, but UDMA mode 5 preferred of course) enabled, on 
> kernels 2.4.3-ac7 and onwards, random lockup on disk access within first 
> few minutes of use - sometimes very quickly after boot, sometimes as 
> much as ten minutes later given use. Running bonnie -s 1024 once or 

Yep. Lots of people see these. I even have people reporting it and not reporting
it on the same board.

Only known cure its to not use DMA. 

