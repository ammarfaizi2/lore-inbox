Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKFMF1>; Mon, 6 Nov 2000 07:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129071AbQKFMFS>; Mon, 6 Nov 2000 07:05:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4688 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129057AbQKFMFF>; Mon, 6 Nov 2000 07:05:05 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 6 Nov 2000 12:03:52 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), goemon@anime.net (Dan Hollis),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A069CA8.5BB5FF20@mandrakesoft.com> from "Jeff Garzik" at Nov 06, 2000 06:57:28 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sl0D-0006B2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think that is reasonable.

I think its totally reasonable.

> The first thing most drivers do is reset the hardware.   That inevitably

Because there is no persistent storage to remember the fact the hardware is
running.

> You are depending on the hardware to keep its state -between- driver
> unload and driver reload.  That seems inherently unstable to me.  It
> amazes me that such is supported.

Well if you want to rewrite the entire module handling and locking so that
mixer levels determine the load/unload behaviour according to AC97 register
combinations and then train users to mute all their inputs before using
rmmod go ahead 8)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
