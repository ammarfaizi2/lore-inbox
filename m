Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFBJN>; Fri, 5 Jan 2001 20:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131121AbRAFBJE>; Fri, 5 Jan 2001 20:09:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45193 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130690AbRAFBIu>;
	Fri, 5 Jan 2001 20:08:50 -0500
Date: Fri, 5 Jan 2001 16:50:28 -0800
Message-Id: <200101060050.QAA09725@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: gresko@kmit.sk
CC: linux-kernel@vger.kernel.org
In-Reply-To: <01010518163400.00980@horalka.kmit.sk> (message from Marek Gresko
	on Fri, 5 Jan 2001 18:16:34 +0100)
Subject: Re: 2.4.0 TCP SYN problem
In-Reply-To: <01010518163400.00980@horalka.kmit.sk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Marek Gresko <gresko@kmit.sk>
   Date: 	Fri, 5 Jan 2001 18:16:34 +0100

   When I initiate connection from Solaris machine everything goes OK. 
   TCP/SYN,ACK segments are OK.

   Can anyone help me?

Does:

bash# echo "0" >/proc/sys/net/ipv4/tcp_ecn

Fix the problem?  If so, please send a bug report to Sun telling them
that they improperly discard IP packets using ECN.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
