Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284955AbRLFDIk>; Wed, 5 Dec 2001 22:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284953AbRLFDIa>; Wed, 5 Dec 2001 22:08:30 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:55823 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284954AbRLFDIV>; Wed, 5 Dec 2001 22:08:21 -0500
Date: Wed, 5 Dec 2001 19:19:19 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: "David S. Miller" <davem@redhat.com>, <lm@bitmover.com>,
        <Martin.Bligh@us.ibm.com>, <riel@conectiva.com.br>,
        <lars.spam@nocrew.org>, <alan@lxorguk.ukuu.org.uk>, <hps@intermeta.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: SMP/cc Cluster description
In-Reply-To: <20011206135224.12c4b123.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.40.0112051915440.1644-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Rusty Russell wrote:

> I'd love to say that I can solve this with RCU, but it's vastly non-trivial
> and I haven't got code, so I'm not going to say that. 8)

Lockless algos could help if we're able to have "good" quiescent point
inside the kernel. Or better have a good quiescent infrastructure to have
lockless code to plug in.



- Davide


