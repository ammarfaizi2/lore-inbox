Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132953AbQLOA1T>; Thu, 14 Dec 2000 19:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132669AbQLOA1K>; Thu, 14 Dec 2000 19:27:10 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14344 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132971AbQLOA06>; Thu, 14 Dec 2000 19:26:58 -0500
Date: Thu, 14 Dec 2000 15:56:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Frost <sfrost@snowman.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Netfilter <netfilter@us5.samba.org>
Subject: Re: test13-pre1 changelog
In-Reply-To: <20001214184544.O26953@ns>
Message-ID: <Pine.LNX.4.10.10012141552180.12695-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, Stephen Frost wrote:
> 
> 	Any idea if these issues would cause a general slow-down of a
> machine?  For no apparent reason after 5 days running 2.4.0test12
> everything going through my firewall (set up using iptables) I got about
> 100ms time added on to pings and traceroutes.

Probably not related to that particular bug - the netfilter issue has
apparently been around forever, and it was just some changes in IP
fragmentation that just made it show up as an oops. 

A 100ms delay sounds like some interrupt shut up or similar (and then
timer handling makes it limp along).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
