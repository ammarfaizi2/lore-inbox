Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbQLMUHS>; Wed, 13 Dec 2000 15:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbQLMUHI>; Wed, 13 Dec 2000 15:07:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40206 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129465AbQLMUG5>; Wed, 13 Dec 2000 15:06:57 -0500
Date: Wed, 13 Dec 2000 11:35:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11 - the continuing saga
In-Reply-To: <Pine.Linu.4.10.10012131856130.448-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.10.10012131131090.19837-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ehh, I think I found it.

Hint: "ptep_mkdirty()".

Oops.

I'll bet you $5 USD (and these days, that's about a gadzillion Euros) that
this explains it.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
