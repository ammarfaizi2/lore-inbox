Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130027AbQLMCRG>; Tue, 12 Dec 2000 21:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130277AbQLMCQ4>; Tue, 12 Dec 2000 21:16:56 -0500
Received: from smtp1.jp.psi.net ([154.33.63.111]:39183 "EHLO smtp1.jp.psi.net")
	by vger.kernel.org with ESMTP id <S130027AbQLMCQt>;
	Tue, 12 Dec 2000 21:16:49 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: RE: Signal 11 - the continuing saga
Date: Wed, 13 Dec 2000 10:45:21 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGKEAKCJAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20001212191719.A12420@vger.timpanogas.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the info...

> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Jeff V. Merkey
> > 	So, is this related to the larger signal 11 problems?
>
> There's a corruption bug in the page cache somewhere, and it's 100%
> reproducable.  Finding it will be tough....

Ok, granted this will be tough but is anyone even actively working on it?
What can I do to help?



> > Anyone know how to do [disable L1 and L2 caches]?
>
> Usually this is performed in the BIOS setup.  You can also disable L1
> with a sequence of instructions that write to the CR0 register on intel
> and flip a bit, but in doing this you have to execute a WBINV (write
> back invalidate) instruction to flush out the cache.  BIOS setup is
> probably simpler.  Disabling Level I will make the machine slower
> than mollasses, BTW, and if this bug is race related (they always
> are) it won't help much in running it down.

Aha, just as I suspected. My BIOS doesn't appear to support this. You seem
to be saying that doing so won't really contribute anything anyway so I will
hold off for now.



--Rainer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
