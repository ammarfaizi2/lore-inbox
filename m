Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129752AbQK0Tg5>; Mon, 27 Nov 2000 14:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129748AbQK0Tgr>; Mon, 27 Nov 2000 14:36:47 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:4892 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S129707AbQK0Tgc>; Mon, 27 Nov 2000 14:36:32 -0500
Date: Mon, 27 Nov 2000 20:06:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Michael Meissner <meissner@spectacle-pond.org>
Cc: "David S. Miller" <davem@redhat.com>, Werner.Almesberger@epfl.ch,
        adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001127200618.A19980@athlon.random>
In-Reply-To: <200011270556.VAA12506@baldur.yggdrasil.com> <20001127094139.H599@almesberger.net> <200011270839.AAA28672@pizda.ninka.net> <20001127182113.A15029@athlon.random> <20001127123655.A16930@munchkin.spectacle-pond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001127123655.A16930@munchkin.spectacle-pond.org>; from meissner@spectacle-pond.org on Mon, Nov 27, 2000 at 12:36:55PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 12:36:55PM -0500, Michael Meissner wrote:
> wrong to depend on two variables winding up in at adjacent offsets.

I'd like if it will be written explicitly in the specs that it's forbidden to
rely on that. I grepped the specs and I didn't find anything. So I wasn't sure
if I missed the information in the specs or not. I never investigated on it
because I always considered it bad coding regardless the fact it's guaranteed
to generate the right asm with the _current_ tools.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
