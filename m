Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbRAGKXJ>; Sun, 7 Jan 2001 05:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130162AbRAGKW6>; Sun, 7 Jan 2001 05:22:58 -0500
Received: from james.kalifornia.com ([208.179.0.2]:22890 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S130139AbRAGKWx>; Sun, 7 Jan 2001 05:22:53 -0500
Date: Sun, 7 Jan 2001 02:22:31 -0800 (PST)
From: David Ford <david@linux.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
 policy!)
In-Reply-To: <20010107162905.B1804@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.10.10101070220410.4173-100000@Huntington-Beach.Blue-Labs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Chris Wedgwood wrote:
> Virtual IP interfaces in the form of ifname:<number> (e.g. eth:1) IMO
> should be deprecated and removed completely in 2.5.x. It's an ugly
> external wart that should be removed.
> 
> That said, if this was done -- how would things like routing daemons
> and bind cope? Actually, when I think about it they can't cope with
> situating like this now:
> 
> tapu:~# ip addr show lo
> 1: lo: <LOOPBACK,UP> mtu 3904 qdisc noqueue
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>     inet 10.0.0.1/32 scope global lo

BIND copes just fine, how would it not?  I haven't heard any problems with
routing daemons either.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
