Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbRCSTxO>; Mon, 19 Mar 2001 14:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131564AbRCSTxE>; Mon, 19 Mar 2001 14:53:04 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:4114 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S131563AbRCSTw6>;
	Mon, 19 Mar 2001 14:52:58 -0500
Date: Tue, 20 Mar 2001 01:22:10 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: lkml <linux-kernel@vger.kernel.org>
Subject: atomic_set(skb_datarefp(skb),1)
Message-ID: <Pine.SOL.3.96.1010320011810.21586A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	I am extremely sorry to bother this group with this message. But I
am really unable to understand the following. So it would be very kind of
you if you clarify this.
 
	In 2.2.16, in the function alloc_skb(),
atomic_set(skb_datarefp(skb),1) is there. Now skb_datarefp() returns 
skb->end casted in (atomic_t *) type. And atomic_set here setting it to
1.

But before atomic_set() is called in alloc_skb(), skb->end is set to
data+size. Now my question is what is the purpose of calling atomic_set()?

regards
sourav 

