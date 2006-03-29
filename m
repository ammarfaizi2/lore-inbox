Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWC2Hud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWC2Hud (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWC2Hud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:50:33 -0500
Received: from king.bitgnome.net ([70.84.111.244]:18130 "EHLO
	king.bitgnome.net") by vger.kernel.org with ESMTP id S1751140AbWC2Huc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:50:32 -0500
Date: Wed, 29 Mar 2006 01:50:33 -0600
From: Mark Nipper <nipsy@bitgnome.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed at net/...
Message-ID: <20060329075032.GF26340@king.bitgnome.net>
References: <20060329060816.GB26340@king.bitgnome.net> <20060328.234119.24811924.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328.234119.24811924.davem@davemloft.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Mar 2006, David S. Miller wrote:
> It's being discussed at the proper place, netdev@vger.kernel.org.
> 
> You have an e1000 card right?  A temporary workaround is to disable
> TSO on that interface.

        Okay.  Sorry for the duplicate.  I just wasn't sure if
anyone saw the first one.

        Yes, it is an e1000.  I disabled TSO via ethtool.  Do I
need to reboot or anything and do this right away to avoid
problems or will the few assertions I've seen thus far not cause
any badness in the kernel?

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
