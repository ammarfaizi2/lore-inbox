Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVK1Mg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVK1Mg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 07:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbVK1Mg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 07:36:58 -0500
Received: from king.bitgnome.net ([70.84.111.244]:17596 "EHLO
	king.bitgnome.net") by vger.kernel.org with ESMTP id S932073AbVK1Mg5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 07:36:57 -0500
Date: Mon, 28 Nov 2005 06:36:01 -0600
From: Mark Nipper <nipsy@bitgnome.net>
To: linux-kernel@vger.kernel.org
Subject: KERNEL: assertion (!sk->sk_forward_alloc) failed
Message-ID: <20051128123601.GA32346@king.bitgnome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        I received the following in my system logs recently:
---
Nov 27 22:56:20 king kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (279)
Nov 27 22:56:20 king kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (151)

        All I could find related to this was some potential bugs
mentioned in 2.6.9 and in particular with relation to TSO.
However, I'm running a vanilla 2.6.13.4 at the moment.  But, I do
have an e1000 and checking ethtool does show TSO on.

        Anyway, ignore if this is unimportant.  The machine is
still up and running, so it doesn't appear to be fatal.  Let me
know if you need my .config or output from dmesg or whatever.  I
guess I'll upgrade to 2.6.14.? or wait for 2.6.15.[12] just to be
safe!

-- 
Mark Nipper                                                e-contacts:
832 Tanglewood Drive                                nipsy@bitgnome.net
Bryan, Texas 77802-4013                     http://nipsy.bitgnome.net/
(979)575-3193                      AIM/Yahoo: texasnipsy ICQ: 66971617

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GG/IT d- s++:+ a- C++$ UBL++++$ P--->+++ L+++$ !E---
W++(--) N+ o K++ w(---) O++ M V(--) PS+++(+) PE(--)
Y+ PGP t+ 5 X R tv b+++@ DI+(++) D+ G e h r++ y+(**)
------END GEEK CODE BLOCK------

---begin random quote of the moment---
"They that can give up essential liberty to obtain a little
temporary safety deserve neither liberty nor safety."
 -- Benjamin Franklin, _Historical Review of Pennsylvania_, 1759
----end random quote of the moment----
