Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130869AbRAHXHH>; Mon, 8 Jan 2001 18:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131208AbRAHXG6>; Mon, 8 Jan 2001 18:06:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:37251 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130869AbRAHXGx>; Mon, 8 Jan 2001 18:06:53 -0500
Date: Mon, 8 Jan 2001 18:06:25 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dan Hollis <goemon@anime.net>
cc: Russell King <rmk@arm.linux.org.uk>,
        Michael Meissner <meissner@spectacle-pond.org>, Ookhoi <ookhoi@dds.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: The advantage of modules?
In-Reply-To: <Pine.LNX.4.30.0101081437030.19618-100000@anime.net>
Message-ID: <Pine.LNX.3.95.1010108174358.6769A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Dan Hollis wrote:

> On Mon, 8 Jan 2001, Russell King wrote:
> > Seriously though, you can't depreciate a term for referring to a type of
> > bus without providing some other term to describe said bus.
> 
> You need to distinguish between SCSI-the-protocol and
> SCSI-the-physical-layer. The term "SCSI" alone is simply too ambiguous to
> be really useful anymore. I think you can use term "SCSI-1" or "SCSI-2"
> when specicfally meaning SCSI protocol over classic 50 wire layer.
> 
> Saying "SCSI does not support hotplug" is very misleading.
> 
> Right now, the term "SCSI" is more akin to "IP".
> 
> -Dan

Err.... The American National Standard for information Systems, under
the American National Standards Institute, ANSI, approved a "Small
Computer System Interface" (SCSI) standard on June 23, 1986.

There have been many revisions, one of the last, called SCSI-2, was
approved on May 20, 1991. I used to sit on the committee. I have some
of the original drafts.

Although I haven't been involved for over 8 years, it us unlikely that
the word "SCSI" has been given up as some generic aspirin. SCSI still
means the stuff specified in the 519 Page document copyrighted by
ANSI, called "SMALL COMPUTER SYSTEM INTERFACE - 2", Dated May 20, 1991,
and the first draft released in June of 1986.

As such, you are not supposed to use the word SCSI to mean "control packet
interface" or whatever. It is supposed to refer to the hardware and
communications specifications (software), defined by the standard.
Although nobody is likely to haul is into court, we should not be using
SCSI to mean anything else.

And, SCSI does not "specify" hot-plug. It's just not covered in the
standard. However, you can certainly provide capabilities not covered
by a particular standard. It is some implementation details on how
SCSI (and other) devices are mounted, connected, disconnected, and
controlled that may allow hot-plugging.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
