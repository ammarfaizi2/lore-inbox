Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132237AbQLVUBh>; Fri, 22 Dec 2000 15:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132256AbQLVUB1>; Fri, 22 Dec 2000 15:01:27 -0500
Received: from NS2.pcscs.com ([207.96.110.42]:32778 "EHLO linux01.pcscs.com")
	by vger.kernel.org with ESMTP id <S131512AbQLVUBQ>;
	Fri, 22 Dec 2000 15:01:16 -0500
Message-ID: <007c01c06c4d$aef446e0$2b6e60cf@pcscs.com>
From: "Charles Wilkins" <chas@pcscs.com>
To: "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
Cc: <linux-raid@vger.kernel.org>
Subject: Fw: max number of ide controllers?
Date: Fri, 22 Dec 2000 14:30:46 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > Charles Wilkins wrote:
> >
> > Is there a max number of ide controllers that linux-2.2.18 can
> > support?
>

Andrzej M. Krzysztofowicz says,

>"Linux supports up to 10 IDE channels, however channel numbers of PCI
controllers seem to be assigned first."

Warren Young says,
>"Kernel 2.2 is limited to 4 IDE controllers."

ok, so which is it kernel guys, 4 or 10 IDE controllers for the 2.2.x
kernel?

> I know 2.4 supports a maximum of 10 controllers, but each controller has
> to use a different I/O port.  The standard ones are 0x1F0 and 0x170.
> The mobo controllers you have probably are fixed to use the common I/O
> ports.  If the Promise controller can be set to use uncommon port
> values, you'll be able to use 4 controllers.

you didn't read the other posts . . .

> The Creative card is probably a loss, because it's probably fixed at I/O
> port 0x170 (second channel).

well, i know this SB32 card can operating on at least 3 different io ports .
. .


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
