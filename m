Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUB2Kgt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 05:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbUB2Kgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 05:36:49 -0500
Received: from aragorn.schlenn.net ([195.177.220.21]:64416 "EHLO
	aragorn.schlenn.net") by vger.kernel.org with ESMTP id S262040AbUB2Kgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 05:36:40 -0500
Message-ID: <3070.172.177.246.117.1078050973.squirrel@www.schlenn.net>
In-Reply-To: <20040228214046.23c31cc2.davem@redhat.com>
References: <20040215212241.GA2752@schlenn.net>
    <20040228214046.23c31cc2.davem@redhat.com>
Date: Sun, 29 Feb 2004 11:36:13 +0100 (CET)
Subject: Re: PROBLEM: /proc/sys/net/ipv4/ip_dynaddr does not work correctly
From: "Michael Schlenstedt" <Michael@schlenn.net>
To: "David S. Miller" <davem@redhat.com>
Cc: "Michael Schlenstedt" <michael-ml-kernel@schlenn.net>,
       linux-kernel@vger.kernel.org, jjciarla@raiz.uncu.edu.ar
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David S. Miller sagte:

> It will only print a "debugging message" if the IP address of the system
> changes and a packet is attempted to be sent over a TCP connection, then
> it will print a message looking like:
>
> tcp_v4_rebuild_header(): shifting iner->saddr from x.x.x.x to y.y.y.y
>
> And it in fact does do this.

Well, it doesn't in my configuration. In fact, there is no function of
dyn_ipaddr at all in my system (even if I use a "echo 1 > ...").

Maybe this is an issue of the combination of pppd and the capi-plugin? I
can remember that I haven't had any problems with pppd and pppoe (and an
early kernel-revision).

Bye,
Michael



-- 
      ___                     Michael@schlenn.net         o
     /_\ `*     `  _ ,  http://www.schlenn.net/~michael  /_\ '         ,,,
    (o o)      -  (o)o)      ICQ: 38605983 (Schlenn)    (o o) -       (o o)
ooO--(_)--Ooo--ooO'(_)--Ooo-------------------------ooO--(_)--Ooo-ooO--(_)--Ooo-

