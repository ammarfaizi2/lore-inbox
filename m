Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289216AbSBJDK0>; Sat, 9 Feb 2002 22:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289224AbSBJDKQ>; Sat, 9 Feb 2002 22:10:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52497 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289216AbSBJDKJ>; Sat, 9 Feb 2002 22:10:09 -0500
Date: Sat, 9 Feb 2002 20:55:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <E16Zjw9-0000Dr-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0202092054080.10530-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Feb 2002, Alan Cox wrote:
>
> This looks a really bad reversion. The CONFIG_DEBUG_BUGVERBOSE ifdef saves
> over 70K of memory on my standard kernel build.

It saves 70k because the old code was total _crap_, and couldn't merge
strings within the same file etc.

With the new code I bet it's less than a kB with new gccs, and probably on
the order of a few kB with old ones.

		Linus

