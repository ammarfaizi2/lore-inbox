Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbQLaVjq>; Sun, 31 Dec 2000 16:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbQLaVjf>; Sun, 31 Dec 2000 16:39:35 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:16042 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129573AbQLaVj2>; Sun, 31 Dec 2000 16:39:28 -0500
Date: Sun, 31 Dec 2000 22:03:05 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.LNX.4.10.10012311035020.4239-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.10.10012312158050.23931-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 31 Dec 2000, Linus Torvalds wrote:

> Let me repeat myself one more time:
> 
>  I do not believe that "get_block()" is as big of a problem as people make
>  it out to be.

The real problem is that get_block() doesn't scale and it's very hard to
do. A recursive per inode-semaphore might help, but it's still a pain to
get it right.

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
