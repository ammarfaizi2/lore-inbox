Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316243AbSEVQ2N>; Wed, 22 May 2002 12:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316244AbSEVQ2M>; Wed, 22 May 2002 12:28:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45585 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316243AbSEVQ2L>; Wed, 22 May 2002 12:28:11 -0400
Date: Wed, 22 May 2002 09:28:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <3CEB5F75.4000009@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0205220925120.7580-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Martin Dalecki wrote:
>
> Remove support for /dev/port altogether.

Yes, I don't think it has actually ever been used.

It was done purely because Minix did it that way, and it wasn't even
compatible with Minix (I think Minix actually supoorted 2- and 4-byte
accesses by just doign 2- and 4-byte read/write calls, the Linux code
never did).

Everybody always used the iobitmap/iopl interfaces under Linux as far as I
know.

Anybody: if you've ever used /dev/ports, holler _now_.

		Linus

