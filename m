Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKREJG>; Fri, 17 Nov 2000 23:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKREI4>; Fri, 17 Nov 2000 23:08:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:58379 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129091AbQKREIj>; Fri, 17 Nov 2000 23:08:39 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: test11-pre7 compile failure
Date: 17 Nov 2000 19:38:17 -0800
Organization: Transmeta Corporation
Message-ID: <8v4tj9$10v$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10011171720410.5987-100000@penguin.transmeta.com> <3A15DDCB.42B0F208@toyota.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A15DDCB.42B0F208@toyota.com>, J Sloan  <jjs@toyota.com> wrote:
>
>looks like the md fixes broke something -
>
>In file included from /usr/src/linux/include/linux/pagemap.h:17,
>                 from /usr/src/linux/include/linux/locks.h:9,
>                 from /usr/src/linux/include/linux/raid/md.h:37,
>                 from init/main.c:25:
>/usr/src/linux/include/linux/highmem.h: In function `bh_kmap':
>/usr/src/linux/include/linux/highmem.h:23: structure has no member named
>`p_page'

The "p_page" should be a "b_page". Duh.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
