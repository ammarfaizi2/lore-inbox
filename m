Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264526AbRF0XLy>; Wed, 27 Jun 2001 19:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265441AbRF0XLo>; Wed, 27 Jun 2001 19:11:44 -0400
Received: from hera.cwi.nl ([192.16.191.8]:16556 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264526AbRF0XLd>;
	Wed, 27 Jun 2001 19:11:33 -0400
Date: Thu, 28 Jun 2001 01:11:30 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106272311.BAA463353.aeb@vlet.cwi.nl>
To: acahalan@cs.uml.edu, hpa@transmeta.com
Subject: Re: [PATCH] User chroot
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not that the documentation on MAP_ANON is any good either
> but at least the mere existence of the flag is mentioned.

> Seriously:
> both features ought to be documented in the man pages
> (I did submit a man page too, back in 1996)

Ah yes, I see. We both wrote a man page, and each contained
stuff not in the other, and I asked you to merge them, but
then nothing happened anymore. Maybe I should merge them
myself.

[In case you do the merging: please distinguish clearly
between what is prescribed by POSIX (or SUSv2, or Austin draft 7)
and what is implemented by (g)libc or the Linux kernel.
I see that your version has prototypes like
	caddr_t mmap(caddr_t  addr, ...
but this caddr_t is typically from BSD, and is void * these days.]

Andries

