Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129277AbQKFLix>; Mon, 6 Nov 2000 06:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129574AbQKFLin>; Mon, 6 Nov 2000 06:38:43 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5132 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129277AbQKFLic>;
	Mon, 6 Nov 2000 06:38:32 -0500
Message-ID: <3A0697AC.2861E576@mandrakesoft.com>
Date: Mon, 06 Nov 2000 06:36:12 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Dan Hollis <goemon@anime.net>, David Woodhouse <dwmw2@infradead.org>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <E13skYq-000697-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > This is why alsa starts up all devices totally muted. Maybe its time for
> > > David to move to alsa ;)
> >
> > I wouldn't mind leaving devices totally muted until open()...
> 
> You need to leave the mixer for cd, tv and radio pass through

Good point.  Also might need to flush default settings to the mixer, if
you start playing w/out first setting the mixer to anything...

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
