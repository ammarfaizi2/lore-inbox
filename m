Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQLBLlP>; Sat, 2 Dec 2000 06:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbQLBLlF>; Sat, 2 Dec 2000 06:41:05 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:3342 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S129525AbQLBLky>; Sat, 2 Dec 2000 06:40:54 -0500
Date: Sat, 2 Dec 2000 11:09:51 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: folkert@vanheusden.com
cc: "Theodore Y Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        vpnd@sunsite.auc.dk
Subject: Re: /dev/random probs in 2.4test(12-pre3)
In-Reply-To: <E141u3g-0006vY-00@post.mail.nl.demon.net>
Message-ID: <Pine.LNX.4.10.10012021108350.31306-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2000 folkert@vanheusden.com wrote:

> > open("/dev/random", O_RDONLY)           = 3
> > read(3, "q\321Nu\204\251^\234i\254\350\370\363\"\305\366R\2708V"..., 72) = 29
> > close(3)                                = 0

> I've seen that happen with kernel version 2.2.16!

Indeed, you are correct.  Is vpnd broken then, for assuming
that it can gather the required randomness in one read?

Matthew.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
