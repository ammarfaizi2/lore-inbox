Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262022AbREPRZp>; Wed, 16 May 2001 13:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262021AbREPRZf>; Wed, 16 May 2001 13:25:35 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:43529 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262017AbREPRZb>; Wed, 16 May 2001 13:25:31 -0400
Date: Wed, 16 May 2001 19:25:12 +0200 (CEST)
From: Axel Siebenwirth <axel@rayfun.org>
To: <linux-kernel@vger.kernel.org>
cc: <realtek@scyld.com>, <realtek-bug@scyld.com>, <linux-net@vger.kernel.org>
Subject: Transmit time out on eth1 (rtl8139) / dirty entry in queue [again]
Message-ID: <Pine.LNX.4.33.0105161910230.10819-100000@neon.rayfun.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this old problem I had been faced with had been solved with 2.4.3-ac13/14,
but now with kernel 2.4.4-ac9 and all other 2.4.4-acx it came up again.
It's a Realtek 8139C chip on a AT2500 (allied telesyn or sumpin like that)

Instead the former

  Apr 24 16:16:57 bello kernel: eth1: Setting half-duplex based on
    auto-negotiated partner ability 0000.

I have now an unconnected cable which is not the fact:)

  May 16 15:20:26 bello kernel: eth1: media is unconnected, link down, or
    incompatible connection
  May 16 15:20:44 bello kernel: NETDEV WATCHDOG: eth1: transmit timed out
  May 16 15:20:44 bello kernel: eth1: Tx queue start entry 783  dirty
    entry 779.
  May 16 15:20:44 bello kernel: eth1:  Tx descriptor 0 is 00002000.
  May 16 15:20:44 bello kernel: eth1:  Tx descriptor 1 is 00002000.
  May 16 15:20:44 bello kernel: eth1:  Tx descriptor 2 is 00002000.
  May 16 15:20:44 bello kernel: eth1:  Tx descriptor 3 is 00002000. (queue
  head)
  May 16 15:20:44 bello kernel: eth1: media is unconnected, link down, or
    incompatible connection

Could I adjust some values, like tx buffer to get it to work?
Please excuse my unscientific nature.
I can as well supply any more information about the scenario...

Regards,
Axel Siebenwirth

