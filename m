Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBIHC1>; Fri, 9 Feb 2001 02:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129026AbRBIHCR>; Fri, 9 Feb 2001 02:02:17 -0500
Received: from [143.89.224.176] ([143.89.224.176]:5636 "EHLO hingwah")
	by vger.kernel.org with ESMTP id <S129031AbRBIHCG>;
	Fri, 9 Feb 2001 02:02:06 -0500
Date: Fri, 9 Feb 2001 14:59:50 +0800
To: linux-kernel@vger.kernel.org
Subject: problem using ppp on serial modem for kernel 2.4.x
Message-ID: <20010209145950.A2641@hingwah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
From: hingwah@programmer.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

	Recently I try to upgrade kernel 2.2.x to 2.4.x (the problem occur
both for 2.4.0 and 2.4.1). When I use kernel 2.2.x before and use the serial modem to connect internet and telnet to some Chinese bbs ( in which 8-bit character is used,e.g bbs.e-fever.org ,bbs.org.hk  ,it work fine. However,when I change to use kernel 2.4.x). Problem occur and the telnet seem hang in the menu, I try to telnet to other machine first and telnet to the bbs again,the problem still occur. However, if I use ssh to connect to other machine and connect to the bbs again, it work fine. I wonder if there is some 8-bit character treated as some control code for pppd. Should I set something about asyncmap in /etc/ppp/options?
I have tried enable "asyncmap 0" or use "defaultasyncmap" or "escape 11,13,ff) but it seem don't work.


P.S I have upgraded to pppd 2.4.x and the address machine can be login by "guest" after the login prompt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
