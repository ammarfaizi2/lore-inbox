Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130568AbQK2BKJ>; Tue, 28 Nov 2000 20:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130572AbQK2BKC>; Tue, 28 Nov 2000 20:10:02 -0500
Received: from anime.net ([63.172.78.150]:16912 "EHLO anime.net")
        by vger.kernel.org with ESMTP id <S130568AbQK2BJr>;
        Tue, 28 Nov 2000 20:09:47 -0500
Date: Tue, 28 Nov 2000 16:39:56 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Petter Sundlöf <odd@findus.dhs.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: XFree 4.0.1/NVIDIA 0.9-5/2.4.0-testX/11 woes [solved]
In-Reply-To: <E140urK-0005FZ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0011281639180.27174-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Alan Cox wrote:
> > Thanks to some nice people in #NVIDIA I found what seems to be a
> > solution; compile with processor type as "K6". No segfaults, lost
> > terminfo or disabled consoles.
> > So are there issues with the K7 processor code? Bleh, never mind, I have
> > no idea what I am talking about.
> The K7 optimisations are not used for I/O space accessess. Or shouldnt be,
> but the nvidia code is unreadable so they may have done so

Dont forget the nvidia driver is completely SMP broken. As in, trash your
filesystems broken.

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
