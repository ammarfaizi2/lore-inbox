Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131506AbQLIPRM>; Sat, 9 Dec 2000 10:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131686AbQLIPRC>; Sat, 9 Dec 2000 10:17:02 -0500
Received: from dusdi4-145-253-116-006.arcor-ip.net ([145.253.116.6]:41221 "EHLO
	al.romantica.wg") by vger.kernel.org with ESMTP id <S131506AbQLIPQm>;
	Sat, 9 Dec 2000 10:16:42 -0500
Date: Sat, 9 Dec 2000 14:54:28 +0100
From: Jens Taprogge <taprogge@idg.rwth-aachen.de>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Cc: Linus Torvalds <torvalds@transmeta.com>, rgooch@ras.ucalgary.ca,
        jgarzik@mandrakesoft.mandrakesoft.com, dhinds@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: Serial cardbus code.... for testing, please.....
Message-ID: <20001209145428.A11104@al.romantica.wg>
Mail-Followup-To: Jens Taprogge <taprogge@idg.rwth-aachen.de>,
	"Theodore Y. Ts'o" <tytso@MIT.EDU>,
	Linus Torvalds <torvalds@transmeta.com>, rgooch@ras.ucalgary.ca,
	jgarzik@mandrakesoft.mandrakesoft.com, dhinds@valinux.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012081319010.11626-100000@penguin.transmeta.com> <200012090541.AAA17863@tsx-prime.MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012090541.AAA17863@tsx-prime.MIT.EDU>; from tytso@MIT.EDU on Sat, Dec 09, 2000 at 12:41:24AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 12:41:24AM -0500, Theodore Y. Ts'o wrote:    
> In the case of the MegaHertz modem PCMCIA card and the Linksys combo
> PCMCIA card, card registers manage to survive the serial driver's UART
> test (although as a 8250 or 16450, instead of the 16550A that's really
> in those cards, meaning it failed the more advanced loopback and FIFO
> tests).

I have a Megaherz card as well. It has been working fine ever since
Linus fixed some issues with the ToPIC97 Cardbus controller. It reports
a 16550A on my machine.

I have been using the card to connect to my ISP day-in and day-out with
no problems.


If you want me to run some specific test on this box let me know.

Jens

PS: I have everything compiled into the kernel.

--
Jens Taprogge

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
