Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSETLX0>; Mon, 20 May 2002 07:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316398AbSETLXZ>; Mon, 20 May 2002 07:23:25 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:27611 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S316397AbSETLXY>;
	Mon, 20 May 2002 07:23:24 -0400
Date: Mon, 20 May 2002 14:23:20 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.5.16: old tulip (de2104x) can't be compiled in
Message-ID: <Pine.GSO.4.43.0205201415340.27490-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.15 and 2.5.16, tulip driver version for old chips (de2104x) can't
be compiled in. make bzImage fails with

drivers/net/net.o(.data+0xcd4): undefined reference to `local symbols in discarded section .text.exit'

It works when compiled as a module.

Another but smaller problem is that it's way too verbose in my setup
(crossover cable to realtek with 8139too driver and 2.4.18). Every
minute it logs the following line:
eth0: 10baseT-HD link ok, status ffffffc8

The computer is Digital Celebris GL 5133 ST with onboard 21040. Works
fine in 2.4.19pre.

-- 
Meelis Roos (mroos@linux.ee)

