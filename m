Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLKJgX>; Mon, 11 Dec 2000 04:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQLKJgN>; Mon, 11 Dec 2000 04:36:13 -0500
Received: from smtp3.jp.psi.net ([154.33.63.113]:15113 "EHLO smtp3.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129183AbQLKJf5>;
	Mon, 11 Dec 2000 04:35:57 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Signal 11
Date: Mon, 11 Dec 2000 18:05:24 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGAEMHCIAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGGELMCIAA.rmager@vgkk.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I just had a Signal 11 even with the patch. What can I do to help
figure this out?


Thanks,

--Rainer

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Friday, December 08, 2000 11:07 PM
To: David Woodhouse
Cc: Andi Kleen; Rainer Mager; linux-kernel@vger.kernel.org; Mark Vojkovich
Subject: Re: Signal 11


> > wrong with it.  I've only seen this under 2.3.x/2.4 SMP kernels.  I
> > would say that this is definitely a kernel problem.=20
>
> XFree86 3.9 and XFree86 4 were rock solid for a _long_ time on 2.[34]
> kernels - even on my BP6=B9. The random crashes started to happen when =
> I
> upgraded my distribution=B2 - and are only seen by people using 2.4. So=
>  I
> suspect that it's the combination of glibc and kernel which is triggeri=
> ng
> it.

Have any of the folks seeing it checked if Ben LaHaise's fixes for the page
table updating race help ?

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
