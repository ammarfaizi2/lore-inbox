Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKFSbG>; Mon, 6 Nov 2000 13:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129099AbQKFSa4>; Mon, 6 Nov 2000 13:30:56 -0500
Received: from [193.120.224.170] ([193.120.224.170]:8592 "EHLO florence.itg.ie")
	by vger.kernel.org with ESMTP id <S129044AbQKFSar>;
	Mon, 6 Nov 2000 13:30:47 -0500
Date: Mon, 6 Nov 2000 18:30:31 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Woodhouse <dwmw2@infradead.org>, Dan Hollis <goemon@anime.net>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <E13sphu-0006O4-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0011061823560.31802-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Alan Cox wrote:

> If the sound card is only used some of the time or setup and then used
> for TV its nice to get the 60K + 128K DMA buffer back when you dont need it
> especially on a low end box
> 

so unload it then - aiui most soundcards will continue passing through
the TV line? right?

or another argument: how common is this case that a box with such
tight memory is used in such a multi-purpose way (sometimes it
uses sounds, mostly not? and even then, for such a case, is it
reasonable to assume the user should deal with the memory
problems? (ie it's not unreasonable to expect them to have to do extra
fiddling with mixer levels).

but surely the vast majority of machines with soundcards have no good
reason for unloading them?

--paulj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
