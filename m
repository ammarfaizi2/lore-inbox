Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284297AbRLRRKv>; Tue, 18 Dec 2001 12:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280771AbRLRRKk>; Tue, 18 Dec 2001 12:10:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25102 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284305AbRLRRKb>; Tue, 18 Dec 2001 12:10:31 -0500
Date: Tue, 18 Dec 2001 09:08:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.21.0112181639240.11499-100000@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.33.0112180907530.2867-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001, Martin Josefsson wrote:
>
> After watchning /proc/interrupts with 30 second intervals I see that I
> only get 43 interrupts/second when playing 16bit 44.1kHz stereo.

That's _exactly_ what you get with a 4kB fragment size.

You have a sane player that asks for a sane fragment size. While whatever
William uses seems to ask for a really small one..

		Linus

