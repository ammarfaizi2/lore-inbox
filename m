Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbQKFLFx>; Mon, 6 Nov 2000 06:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129144AbQKFLFn>; Mon, 6 Nov 2000 06:05:43 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37387 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129098AbQKFLFb>;
	Mon, 6 Nov 2000 06:05:31 -0500
Message-ID: <3A069036.2D64BD96@mandrakesoft.com>
Date: Mon, 06 Nov 2000 06:04:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Hollis <goemon@anime.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <Pine.LNX.4.21.0011060302290.17667-100000@anime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hollis wrote:
> 
> On Mon, 6 Nov 2000, Alan Cox wrote:
> > And they don't solve the problem David was talking about. There is a short
> > deeply unpleasant scream from some soundcards on reload because the card init
> > and the 0.5-1 second later aumix run dont stop the feedback loop fast enough
> > when a mic is plugged in
> 
> This is why alsa starts up all devices totally muted. Maybe its time for
> David to move to alsa ;)

I wouldn't mind leaving devices totally muted until open()...

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
