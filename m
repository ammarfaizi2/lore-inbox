Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129123AbQKFLKe>; Mon, 6 Nov 2000 06:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129127AbQKFLKY>; Mon, 6 Nov 2000 06:10:24 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:44043 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129123AbQKFLKP>;
	Mon, 6 Nov 2000 06:10:15 -0500
Message-ID: <3A069181.F82DD71@mandrakesoft.com>
Date: Mon, 06 Nov 2000 06:09:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Dan Hollis <goemon@anime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <Pine.LNX.4.21.0011060302290.17667-100000@anime.net> <24273.973508761@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> goemon@anime.net said:
> >  This is why alsa starts up all devices totally muted. Maybe its time
> > for David to move to alsa ;)
> 
> Muted is not what I want either, although that's fine when the module is
> _first_ loaded after booting.
> 
> What I want is for the mixer settings not to change at all, when the module
> is auto-unloaded and later auto-loaded again. I may have set them to pass
> through the line input.

The API allows for setup activity to occur on the fd before sound is
actually started, mixer setup can be one of those steps...

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
