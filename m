Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLMKGs>; Wed, 13 Dec 2000 05:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130493AbQLMKGi>; Wed, 13 Dec 2000 05:06:38 -0500
Received: from smtp1.jp.psi.net ([154.33.63.111]:37642 "EHLO smtp1.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129387AbQLMKGU>;
	Wed, 13 Dec 2000 05:06:20 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: "Linus Torvalds" <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Signal 11 - the continuing saga
Date: Wed, 13 Dec 2000 18:34:52 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGAEBJCJAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <916pol$5qr$1@penguin.transmeta.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Give that man a cigar....it was an env var (not LOCALE but LANG). I'd
actually checked this but I didn't think that made a difference in my case.

Thanks Linus, now can you fix the larger signal 11 problem?

--Rainer


> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Linus Torvalds
> I'd guess that the program has a bug, and depending on the arguments and
> environment (especially the latter will be different), it shows up or
> not. Things like not having a LOCALE set in either case or similar.
>
> 		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
