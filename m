Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283711AbRLEDOi>; Tue, 4 Dec 2001 22:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283715AbRLEDO2>; Tue, 4 Dec 2001 22:14:28 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:7 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283711AbRLEDON>; Tue, 4 Dec 2001 22:14:13 -0500
Date: Tue, 4 Dec 2001 19:25:01 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "David S. Miller" <davem@redhat.com>
cc: lm@bitmover.com, <Martin.Bligh@us.ibm.com>, <riel@conectiva.com.br>,
        <lars.spam@nocrew.org>, <alan@lxorguk.ukuu.org.uk>, <hps@intermeta.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: SMP/cc Cluster description
In-Reply-To: <20011204.183601.22018455.davem@redhat.com>
Message-ID: <Pine.LNX.4.40.0112041919020.1569-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001, David S. Miller wrote:

>    From: Larry McVoy <lm@bitmover.com>
>    Date: Tue, 4 Dec 2001 16:36:46 -0800
>
>    OK, so start throwing stones at this.  Once we have a memory model that
>    works, I'll go through the process model.
>
> What is the difference between your messages and spin locks?
> Both seem to shuffle between cpus anytime anything interesting
> happens.
>
> In the spinlock case, I can thread out the locks in the page cache
> hash table so that the shuffling is reduced.  In the message case, I
> always have to talk to someone.

Time ago I read an interesting article that implemented shared memory over
network ( ATM in that case ) reproducing in large scale the
cache/memory/bus computer architecture.
Shared memory on each node was the equivalent of the CPU cache, a "generic
shared memory repository" was the equivalent of the main memory and the
snooping traffic was running on the network.
I think I picked it up from ACM but I can't find it right now.




- Davide


