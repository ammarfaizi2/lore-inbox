Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbQKFLGD>; Mon, 6 Nov 2000 06:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129144AbQKFLFx>; Mon, 6 Nov 2000 06:05:53 -0500
Received: from anime.net ([63.172.78.150]:60423 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S129131AbQKFLFi>;
	Mon, 6 Nov 2000 06:05:38 -0500
Date: Mon, 6 Nov 2000 03:03:16 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <E13sju0-00065u-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0011060302290.17667-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Alan Cox wrote:
> And they don't solve the problem David was talking about. There is a short
> deeply unpleasant scream from some soundcards on reload because the card init
> and the 0.5-1 second later aumix run dont stop the feedback loop fast enough
> when a mic is plugged in

This is why alsa starts up all devices totally muted. Maybe its time for
David to move to alsa ;)

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
