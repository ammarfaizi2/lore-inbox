Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129331AbRBKMEk>; Sun, 11 Feb 2001 07:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129235AbRBKMEU>; Sun, 11 Feb 2001 07:04:20 -0500
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:52496 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129124AbRBKMES>; Sun, 11 Feb 2001 07:04:18 -0500
Date: Sun, 11 Feb 2001 11:57:43 +0000
To: Tim Krieglstein <tstone@rbg.informatik.tu-darmstadt.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Easy Way to FS-corruption
Message-ID: <20010211115743.A981@colonel-panic.com>
Mail-Followup-To: pdh,
	Tim Krieglstein <tstone@rbg.informatik.tu-darmstadt.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E14RawY-0000HB-00@TimeKeeper>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14RawY-0000HB-00@TimeKeeper>; from tstone@t-online.de on Sat, Feb 10, 2001 at 03:24:06PM +0100
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2001 at 03:24:06PM +0100, Tim Krieglstein wrote:
> 
> I found a way which seems to lead to an "easy" way of fs-corruption:
> Install two sound-cards, use the newest ALSA-Drivers 0.5.10b 
> (the standard sound drivers don't work to good with sf) and

[snip]

This could be that bus master DMA caching problem that showed up on my
KT133 A7V (see previous threads re: 'VIA silent disk corruption'). You
could try more conservative BIOS chipset settings (my problem went away
with "normal" rather than "optimal" BIOS settings). In the end Asus
released a BIOS update for the A7V that seems to have fixed it
permanently.

P.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
