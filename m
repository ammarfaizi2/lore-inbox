Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131066AbQLPG4O>; Sat, 16 Dec 2000 01:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQLPG4F>; Sat, 16 Dec 2000 01:56:05 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5645 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131066AbQLPGzp>; Sat, 16 Dec 2000 01:55:45 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: test13pre2 - netfilter modiles compile failure
Date: 15 Dec 2000 22:25:02 -0800
Organization: Transmeta Corporation
Message-ID: <91f1ru$4e3$1@penguin.transmeta.com>
In-Reply-To: <3A3AF5F5.BDC853F4@haque.net> <200012160552.VAA27106@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200012160552.VAA27106@pobox.com>,
Barry K. Nathan <barryn@pobox.com> wrote:
>I got the same error with the ipchains-compatible netfilter compiled as
>modules. Compiling into the kernel instead, I also get an error. I've
>included the error and my .config below.

Try removing "$(ip_conntrack-objs) $(iptable_nat-objs)" from the
ip_nf_compat-objs line in net/ipv4/netfilter/Makefile..

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
