Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282071AbRK2Tnq>; Thu, 29 Nov 2001 14:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282396AbRK2Tnh>; Thu, 29 Nov 2001 14:43:37 -0500
Received: from unused ([66.187.233.239]:47880 "EHLO mail.redhat.com")
	by vger.kernel.org with ESMTP id <S282071AbRK2TnT>;
	Thu, 29 Nov 2001 14:43:19 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111291911.WAA06769@ms2.inr.ac.ru>
Subject: Re: net/ipv4/arp.c: arp_rcv, rfc2131 BREAKS communication
To: ja@ssi.bg (Julian Anastasov)
Date: Thu, 29 Nov 2001 22:11:40 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111261212330.3166-100000@l> from "Julian Anastasov" at Nov 26, 1 02:15:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> directly. I'm not sure there is a standard for duplicate address
> detection.

The procedure is prescribed in rfc on dhcp, which is sort of standard.


> In this case the gap for race is small.

There is no races there. Before DAD did not pass address must not be used,
that's all. This is also described unambigously in dhcp specs.

Alexey
