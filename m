Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAaKSv>; Wed, 31 Jan 2001 05:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129965AbRAaKSl>; Wed, 31 Jan 2001 05:18:41 -0500
Received: from [195.71.115.196] ([195.71.115.196]:6951 "HELO
	demdwug7.mediaways.net") by vger.kernel.org with SMTP
	id <S129444AbRAaKSa>; Wed, 31 Jan 2001 05:18:30 -0500
Date: Wed, 31 Jan 2001 11:19:39 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Aaron Tiensivu <mojomofo@mojomofo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12: SiS pirq handling..
In-Reply-To: <Pine.LNX.4.10.10101291523470.9984-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101310320420.2065-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Linus Torvalds wrote:

> Now, will the two people in the world who know the pirq black magic now
> stand up and confirm or deride my interpretation?

since I'm certainly not the other one, I'm not going to confirm it ;-)
But, besides it sounds reasonable, I could give some more ammu:

my IDE controller is located in the SiS5591 hostbridge (device 00:00)
and the BIOS didn't provide a routing table entry for this device.
Hence, instead of the confusing conflict messages, I get:

SIS5513: IDE controller on PCI bus 00 dev 01
IRQ for 00:00.1:0 -> not found in routing table

which you may take for a vice-versa prove of your explanation.

Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
