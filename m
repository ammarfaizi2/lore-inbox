Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281966AbRKZRxB>; Mon, 26 Nov 2001 12:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281969AbRKZRws>; Mon, 26 Nov 2001 12:52:48 -0500
Received: from unamed.infotel.bg ([212.39.68.18]:17936 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id <S281966AbRKZRwW>;
	Mon, 26 Nov 2001 12:52:22 -0500
Date: Mon, 26 Nov 2001 19:55:23 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@l>
To: Hisham Kotry <etsh_cucu@yahoo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <ja@ssi.bg>
Subject: Re: routing issue
Message-ID: <Pine.LNX.4.33.0111261943490.13694-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Hisham Kotry wrote:

> I have been trying to find a direct kernel hack that
> forces the linux kernel -any version- to use
> postrouting instead of prerouting, I have my reasons
> why I do not want to use netfilter, I currently use
> another FW, but I have this problem with routing, is
> there a way to fix it?

	There are some issues with netfilter+routing but it depends on
your setup. There are patches for this. You have to explain your
problem with the routing because Netfilter uses both pre- and
post-routing for different things. Your statement is ambigous. Do
you mean using the filtering in post_routing or what? I assume it
should be something with NAT but better you to explain.

Regards

--
Julian Anastasov <ja@ssi.bg>

