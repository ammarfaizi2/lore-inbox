Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280083AbRKEA5b>; Sun, 4 Nov 2001 19:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280084AbRKEA5V>; Sun, 4 Nov 2001 19:57:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1804 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280083AbRKEA5L>; Sun, 4 Nov 2001 19:57:11 -0500
Date: Sun, 4 Nov 2001 16:54:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <jogi@planetzork.ping.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.14-pre8..
In-Reply-To: <20011104220641.A788@planetzork.spacenet>
Message-ID: <Pine.LNX.4.33.0111041652400.14237-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Nov 2001 jogi@planetzork.ping.de wrote:
>
> with the complete patch (s.b.) the kernel did kill processes while running
> make -j100. So I tried only the second part of the patch (the SetPage-part)
> and here are the results (this time only the make -j100 part:
>
> 2.4.14-pre8vmscan2:   6:12.06
> 2.4.14-pre8vmscan2:   6:41.43
> 2.4.14-pre8vmscan2:   6:53.22
> 2.4.14-pre8vmscan2:   7:12.03
> 2.4.14-pre8vmscan2:   5:49.82

Good. So at least that one seems to explain (and fix) the "non-repeatable
performance".  That's the one that worried me the most in your load. It
still has some variation, but it's a _lot_ better. Thanks,

		Linus

