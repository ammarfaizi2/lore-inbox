Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130614AbQKTDxK>; Sun, 19 Nov 2000 22:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbQKTDwv>; Sun, 19 Nov 2000 22:52:51 -0500
Received: from anime.net ([63.172.78.150]:48911 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S129732AbQKTDwb>;
	Sun, 19 Nov 2000 22:52:31 -0500
Date: Sun, 19 Nov 2000 19:22:32 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        <linux-kernel@vger.kernel.org>
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <200011192053.VAA23987@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.30.0011191916580.18624-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000, Rogier Wolff wrote:
> Someone wrote:
> > > > So change the CMOS-settings so that the BIOS changes the boot order
> > > > from A, C, CD-ROM to C first instead.  *grin*  How long do you want
> > > > to keep playing Tic-Tac-Toe?
> > > Writeprotect the flashbios with the motherboard jumper, and remove the
> > > cmos battery.
> The "writeprotect flashbios" usually only protects the bottom 8k of
> the CMOS. That's the part that you still need to boot the system to
> reflash it should somehow your flash be nuked.

The writeprotect jumper on all motherboards ive seen physically prevent
erase/program voltages from reaching the flash chip (usually pin 1, Vpp).

This is why enabling writeprotect jumper on motherboards also prevents
the ECSD area from being updated (which is outside the bottom 8k
bootblock).

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
