Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAIW52>; Tue, 9 Jan 2001 17:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129859AbRAIW5R>; Tue, 9 Jan 2001 17:57:17 -0500
Received: from anime.net ([63.172.78.150]:23305 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S129406AbRAIW5F>;
	Tue, 9 Jan 2001 17:57:05 -0500
Date: Tue, 9 Jan 2001 14:58:28 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: "David S. Miller" <davem@redhat.com>
cc: <mingo@elte.hu>, <stephenl@zeus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101092203.OAA05934@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101091456160.7153-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, David S. Miller wrote:
>    Just extend sendfile to allow any fd to any fd. sendfile already
>    does file->socket and file->file. It only needs to be extended to
>    do socket->file.
> This is not what senfile() does, it sends (to a network socket) a
> file (from the page cache), nothing more.

Ok in any case, it would be nice to have a generic sendfile() which works
on any fd's - socket or otherwise.

What sort of sendfile() behaviour is defined with select()? Can it be
asynchronous?

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
