Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129202AbQKFLIn>; Mon, 6 Nov 2000 06:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQKFLId>; Mon, 6 Nov 2000 06:08:33 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:32250 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129202AbQKFLIZ>;
	Mon, 6 Nov 2000 06:08:25 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21.0011060302290.17667-100000@anime.net> 
In-Reply-To: <Pine.LNX.4.21.0011060302290.17667-100000@anime.net> 
To: Dan Hollis <goemon@anime.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 11:06:01 +0000
Message-ID: <24273.973508761@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


goemon@anime.net said:
>  This is why alsa starts up all devices totally muted. Maybe its time
> for David to move to alsa ;)

Muted is not what I want either, although that's fine when the module is 
_first_ loaded after booting.

What I want is for the mixer settings not to change at all, when the module
is auto-unloaded and later auto-loaded again. I may have set them to pass 
through the line input.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
