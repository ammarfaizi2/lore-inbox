Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272872AbTHEQhQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272873AbTHEQhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:37:16 -0400
Received: from pwmail.portoweb.com.br ([200.248.222.108]:44730 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S272872AbTHEQhM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:37:12 -0400
Date: Tue, 5 Aug 2003 13:36:17 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Adrian Bunk <bunk@fs.tum.de>
cc: Jakob Oestergaard <jakob@ostenfeld.dk>,
       Dave Jones <davej@codemonkey.org.uk>, <linux-kernel@vger.kernel.org>,
       <trivial@rustcorp.com.au>
Subject: Re: [2.4 patch] fix a compile warning in sbc60xxwdt.c
In-Reply-To: <20030803105741.GM16426@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0308051334370.2848-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adrian, 

I really prefer having these warning fixes, even if they are Obviously
Right (tm), come to me through the maintainer.

If the respective maintainers dont respond in lets say 1 month, then 
please resend me saying "I've tried to contact the maintainer with no 
success". 

I appreciate your work, but I also care about driver maintainers.

Thank you.

On Sun, 3 Aug 2003, Adrian Bunk wrote:

> I got the following compile warning in 2.4.22-pre10:
> 
> <--  snip  -->
> 
> ...
> gcc -D__KERNEL__ 
> -I/home/bunk/linux/kernel-2.4/linux-2.4.22-pre10-full/include -
> Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
> include -DKBUILD_BASENAME=sbc60xxwdt  -c -o sbc60xxwdt.o sbc60xxwdt.c
> sbc60xxwdt.c: In function `sbc60xxwdt_init':
> sbc60xxwdt.c:338: warning: label `err_out' defined but not used

