Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263028AbTDBPN5>; Wed, 2 Apr 2003 10:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263029AbTDBPN5>; Wed, 2 Apr 2003 10:13:57 -0500
Received: from chaos.analogic.com ([204.178.40.224]:19606 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263028AbTDBPN4>; Wed, 2 Apr 2003 10:13:56 -0500
Date: Wed, 2 Apr 2003 10:26:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: my linux does not accept redirects
In-Reply-To: <Pine.LNX.4.51.0304021657090.2465@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.53.0304021019210.30327@chaos>
References: <Pine.LNX.4.51.0304021657090.2465@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Maciej Soltysiak wrote:

> Hi,
>
> There are 2 routers on my network.
> Router A routes to other internal networks
> Router B routes to the Internet
>
> My box has A as the default gateway.
> It should get redirects for the Internet hosts and it does.
> But despite icmp redirects are not filtered and
> /proc/sys/net/ipv4/conf/eth1/accept_redirects is 1 it does not learn
> the paths and i simply get flooded by the router with redirects about
> every single packet that is sent.
>
> What could be wrong?
>

How would it learn? If everybody is going to set their default
route to your box A, and box A routes internally, then box A needs its
default route to go to the internet-box B.

The existnce of ICMP redirects means that your network is not
configured correctly. They are a symptom. A correctly configured
network does not have ICMP redirects.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

