Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275994AbRJKKoN>; Thu, 11 Oct 2001 06:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRJKKoD>; Thu, 11 Oct 2001 06:44:03 -0400
Received: from javier.dnp.fmph.uniba.sk ([158.195.25.195]:20375 "EHLO
	javier.dnp.fmph.uniba.sk") by vger.kernel.org with ESMTP
	id <S275981AbRJKKnr>; Thu, 11 Oct 2001 06:43:47 -0400
Date: Thu, 11 Oct 2001 12:43:29 +0200 (CEST)
From: Daniel Kollar <dkollar@fmph.uniba.sk>
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: parport compile error
Message-ID: <Pine.LNX.4.21.0110111233520.2633-100000@javier.dnp.fmph.uniba.sk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get following error message when compiling parport as a module in
2.4.12:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.12/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o
ieee1284_ops.o ieee1284_ops.c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in
this function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in
this function)

D.

