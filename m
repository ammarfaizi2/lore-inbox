Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLaDnO>; Sat, 30 Dec 2000 22:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130643AbQLaDnE>; Sat, 30 Dec 2000 22:43:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64260 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129436AbQLaDm7>; Sat, 30 Dec 2000 22:42:59 -0500
Date: Sat, 30 Dec 2000 19:12:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Steven Cole <elenstev@mesatop.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: test13-pre7...
In-Reply-To: <00123019575800.01541@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10012301910420.1904-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Dec 2000, Steven Cole wrote:
>
> It looks like 2.4.0-test13-pre7 is a clear winner when running dbench 48
> on my somewhat slow test machine (450 Mhz P-III, 192MB, IDE).

This is almost certainly purely due to changing (some would say "fixing")
the bdflush synchronous wait point.

No actual code was harmed in the making of this improvement.

But I will take full credit anyway.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
