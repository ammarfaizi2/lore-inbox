Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbQLISo4>; Sat, 9 Dec 2000 13:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130085AbQLISoq>; Sat, 9 Dec 2000 13:44:46 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34308 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129881AbQLISok>; Sat, 9 Dec 2000 13:44:40 -0500
Date: Sat, 9 Dec 2000 10:13:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Taprogge <taprogge@idg.rwth-aachen.de>
cc: "Theodore Y. Ts'o" <tytso@MIT.EDU>, rgooch@ras.ucalgary.ca,
        jgarzik@mandrakesoft.mandrakesoft.com, dhinds@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: Serial cardbus code.... for testing, please.....
In-Reply-To: <20001209145428.A11104@al.romantica.wg>
Message-ID: <Pine.LNX.4.10.10012091011070.1574-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Dec 2000, Jens Taprogge wrote:
> 
> I have a Megaherz card as well. It has been working fine ever since
> Linus fixed some issues with the ToPIC97 Cardbus controller. It reports
> a 16550A on my machine.

I checked my VAIO's, and they all have a Ricoh cardbus bridge.

Ted claimed he had a TI1311 or something, I think. So his VAIO is
definitely different from the ones I have. That may be enough of a
difference.

(But I know I've tried TI bridges too, and have had multiple success
reports with them. They are not uncommon. They _do_ tend to need more
initialization than some of the other bridges, and maybe that's the
difference. Ted, can you send me the lspci -vvxxx output with the full
config space setup?)

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
