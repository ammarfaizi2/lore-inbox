Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273110AbRIOWnC>; Sat, 15 Sep 2001 18:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273112AbRIOWmv>; Sat, 15 Sep 2001 18:42:51 -0400
Received: from as1-5-2.tbg.s.bonet.se ([217.215.34.209]:10381 "EHLO
	flashdance.cx") by vger.kernel.org with ESMTP id <S273110AbRIOWmp>;
	Sat, 15 Sep 2001 18:42:45 -0400
Date: Sun, 16 Sep 2001 00:43:35 +0200 (CEST)
From: Peter Magnusson <iocc@flashdance.nothanksok.cx>
X-X-Sender: <iocc@flashdance>
To: <linux-kernel@vger.kernel.org>
Subject: broken VM in 2.4.10-pre9
Message-ID: <Pine.LNX.4.33L2.0109160031500.7740-100000@flashdance>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.7: good VM
2.4.8: not good
2.4.9: not good!!!++
2.4.10-pre4: quite ok VM, but put little more on the swap than 2.4.7
2.4.10-pre8: not good
2.4.10-pre9: not good ... Linux didnt had used any swap at all, then i
             unrared two very large files at the same time. And now 104
             Mbyte swap is used! :-( 2.4.7 didnt do like this.
             Best is to use the swap as little as possible.

My cfg:

Real mem: 512684K (512 Mbyte)
Swap    : 257032K
compiled with: gcc version 2.96 20000731 (Linux-Mandrake 8.0 2.96-0.48mdk)


!! remove "nothanksok." from my email if you want to reply to me !!




